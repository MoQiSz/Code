local Loading = {} do

    function Loading:SetLoading(main, path, load, count, number)
        local Loader, Connect
        if load ~= 0 then
            local NotifyHolder = Instance.new("ScreenGui")
            NotifyHolder.Parent = game:GetService("CoreGui")

            setmetatable(main.Options, {
                __len = function(t)
                    local c = 0
                    for n, r in next, t do
                        c += 1
                    end
                    return c
                end
            })
            Connect = main.Window.Root.DescendantAdded:Connect(
                function(Child)
                    if Child:IsA("TextButton") and main.Loaded < 100 then
                        main.Loaded += (main.Loaded < count and #main.Options / #main.Options) or number
                    end
                end
            )
            task.spawn(
                function()
                    Loader = main:Notify(
                        {
                            Title = "[Loading]"..main.Name,
                            SubContent = "0% / 100%",
                            Disable = true,
                            Duration = function()
                                repeat
                                    main.NotifyHolder.Parent = NotifyHolder

                                    if main.GUI and main.GUI.Enabled then
                                        main.GUI.Enabled = false
                                    end

                                    if not path and main.GUI.Parent then
                                        Loader.SubContentLabel.Text = (main.Loaded >= 100 and "100") or tostring(main.Loaded).."% / 100%"

                                        if main.Loaded >= 100 then
                                            if Connect.Connected then
                                                Connect:Disconnect()
                                            end
                                            task.wait(0.55)
                                            break
                                        else
                                            main.Loaded += 1
                                        end

                                        pcall(
                                            function()
                                                Loader.SubContentLabel.Text = (main.Loaded >= 100 and "100") or tostring(main.Loaded).."% / 100%"
                                            end
                                        )
                                    end

                                    task.wait()
                                until not main.GUI.Parent
                                task.spawn(
                                    function()
                                        if main.GUI.Parent then
                                            main.GUI.Enabled = true
                                            main.NotifyHolder.Parent = main.GUI
                                            NotifyHolder:Destroy()
                                            if Connect.Connected then
                                                Connect:Disconnect()
                                            end
                                        end
                                    end
                                )
                            end
                        }
                    )
                end
            )
        else
            main.GUI.Enabled = true
            main.NotifyHolder.Parent = main.GUI
        end
    end

end
return Loading

