Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561226DE4B6
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Apr 2023 21:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjDKTVX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 11 Apr 2023 15:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjDKTVW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 11 Apr 2023 15:21:22 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2774469A
        for <linux-pwm@vger.kernel.org>; Tue, 11 Apr 2023 12:21:21 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id j1so12643273wrb.0
        for <linux-pwm@vger.kernel.org>; Tue, 11 Apr 2023 12:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681240880; x=1683832880;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6WsD3ulAldrPfl4jq7HzDtaOpVHHFfOPvMBT4AIJDvI=;
        b=q/C67sxnz6klbc/YjWmAgCrDV+pCyZSUsDjbbYPcC2gjrlQddiAPKpqQO7dGM0jeuX
         LYUXQ7tfcVL/x2A3N4o92v0oWn937zYcqDt7jdzqBOF032FuB0Qcb7mgkbuY+H4aH5XQ
         dG85J8Cqf47Uo8U0fJxhAIp+Q4njGXRsY2zftUNklFIkZWXfv+QQ92iv1YbHQXOFRLKo
         JaREsPsF/KmU6UyURrb82rYNCvFYICOELosv3Z2D4cqUTZdfmDxPOf7iQugsVpxJkqYO
         rYNENj7nnuAmovASNSyFaL2mxZJV+UPk0b27asFTuVt5vMqYITLoGK/QPisaddcpM6YH
         uqIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681240880; x=1683832880;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6WsD3ulAldrPfl4jq7HzDtaOpVHHFfOPvMBT4AIJDvI=;
        b=w+neCaGLLIrhqAbcApgXV/RwiSu68jC8bhDmnFVr6W0IGGL49tDiPW/+OyO+RMPxIA
         dyzebVptVXpJaNj3ughUBzPcYG/2u9Trty/1pWpPvHnxK7UEr3zi2LxvX0KF9bGxwmS0
         nxcTKHGUpH/jrtDRBScpBaVGORtyBrx7fdInNOqdE9RYlphK7LzE+dQAOcgujN6rzcUi
         k0P8baqz1bRZF+ulFsaRtTv1EPp99Tl3EVs6P2Vu/2d+arYSpGSXgnOVfMILqEJxLOmp
         0rBFDbjaIbGXLI7BG1Om85qZKmKbJq3n/4WXNMOtfLtyvZ/DpC/PUZ6YPgFrV+y3rAVA
         PS6g==
X-Gm-Message-State: AAQBX9fNvX9zGIBVs60prm6TwsQ+XXMXe42oROkRst4Pz/QUXHV4L0uv
        x6rb3lofEU0qoMqjpjPjj7M6cGRrDwA=
X-Google-Smtp-Source: AKy350aNZsG65tT5LwNBQ3xRfgNbyGtgCVak19iUXnnhOUDj+Gj5w/NbPmbs3LiWJPjPl7MhCuBlBQ==
X-Received: by 2002:a05:6000:1a47:b0:2f1:dae:100c with SMTP id t7-20020a0560001a4700b002f10dae100cmr145987wry.5.1681240879859;
        Tue, 11 Apr 2023 12:21:19 -0700 (PDT)
Received: from ?IPV6:2a01:c23:c4bb:c200:90e3:4731:63e4:d333? (dynamic-2a01-0c23-c4bb-c200-90e3-4731-63e4-d333.c23.pool.telefonica.de. [2a01:c23:c4bb:c200:90e3:4731:63e4:d333])
        by smtp.googlemail.com with ESMTPSA id fm7-20020a05600c0c0700b003f063a709dbsm3886004wmb.2.2023.04.11.12.21.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 12:21:19 -0700 (PDT)
Message-ID: <0f087629-810d-f0e0-bf0b-05ca5defc16d@gmail.com>
Date:   Tue, 11 Apr 2023 21:21:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2 0/4] pwm: meson: make full use of common clock framework
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-pwm@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Newer versions of the PWM block use a core clock with external mux,
divider, and gate. These components either don't exist any longer in
the PWM block, or they are bypassed.
To minimize needed changes for supporting the new version, the internal
divider and gate should be handled by CCF too.

I didn't see a good way to split the patch, therefore it's somewhat
bigger. What it does:

- The internal mux is handled by CCF already. Register also internal
  divider and gate with CCF, so that we have one representation of the
  input clock: [mux] parent of [divider] parent of [gate]
  
- Now that CCF selects an appropriate mux parent, we don't need the
  DT-provided default parent any longer. Accordingly we can also omit
  setting the mux parent directly in the driver.
  
- Instead of manually handling the pre-div divider value, let CCF
  set the input clock. Targeted input clock frequency is
  0xffff * 1/period for best precision.
  
- For the "inverted pwm disabled" scenario target an input clock
  frequency of 1GHz. This ensures that the remaining low pulses
  have minimum length.

I don't have hw with the old PWM block, therefore I couldn't test this
patch. With the not yet included extension for the new PWM block
(channel->clock directly coming from get_clk(external_clk)) I didn't
notice any problem. My system uses PWM for the CPU voltage regulator
and for the SDIO 32kHz clock.

Note: The clock gate in the old PWM block is permanently disabled.
This seems to indicate that it's not used by the new PWM block.

Changes to RFT/RFC version:
- use parent_hws instead of parent_names for div/gate clock
- use devm_clk_hw_register where the struct clk * returned by
  devm_clk_register isn't needed

v2:
- add patch 1
- add patch 3
- switch to using clk_parent_data in all relevant places

Heiner Kallweit (4):
  pwm: meson: switch to using struct clk_parent_data for mux parents
  pwm: meson: don't use hdmi/video clock as mux parent
  pwm: meson: change clk/pwm gate from mask to bit
  pwm: meson: make full use of common clock framework

 drivers/pwm/pwm-meson.c | 194 +++++++++++++++++++++-------------------
 1 file changed, 101 insertions(+), 93 deletions(-)

-- 
2.40.0


