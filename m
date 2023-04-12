Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F806DFE9D
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Apr 2023 21:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjDLTSw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 12 Apr 2023 15:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjDLTSv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 12 Apr 2023 15:18:51 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268752108
        for <linux-pwm@vger.kernel.org>; Wed, 12 Apr 2023 12:18:50 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5066ce4f725so14591a12.1
        for <linux-pwm@vger.kernel.org>; Wed, 12 Apr 2023 12:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681327128; x=1683919128;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rHL+GbEo29m7+N9Hj3u8ApA5PF4c2FErCrr9m7viWrc=;
        b=XUDR4nB0r8hdQDueDtsXYXRwv47FYJ72enFG0KDr7q9k8WYFzxn0Dh1oxOX5Uj/hna
         l/cWQ7GPfyov3gbxO4JyE5fl7dpGuMrSKqlGFPP6sT59Yv3Cr3E2BdI+ISrODgioRlWK
         6MMiubj6KujBlUG6s5AQ7ln/QTpGuSBHPTOZ2xVD3d+8Tu4tt6CKDM66RjnE/BDuweip
         gK/fjdjIbHNc30j7dkQP1cOI+HZ9uTMVC7If42TSjJGjzfTbz4LuPBA7eoMUr0FQhibw
         UvDXexs26xcrOmwr1DEqB1syCbO/K7uOMRvEbWoNGb+OK0g8hGf2o7j0q5xZQ4WWMTpo
         ZAoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681327128; x=1683919128;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rHL+GbEo29m7+N9Hj3u8ApA5PF4c2FErCrr9m7viWrc=;
        b=AQHGOKk6y0jzAtUJss0+xlGZwzjDO5F/wOrPMmIBqr95CDkoMjYzUpBIT9rSLNLKkX
         asCjBTbsX28haE7L7JYCe+rJV1ddE4UPtqulxrWjjITYBQQ73tzTu0jQleh4Wg2pqrey
         rMXCKb6KJUPHJuosHS+XKog5VTC9eM246ayDQFgR+SWyXJ1rP8SDsWrCTrO1YIV20Zc2
         4ok3v9mCFVmfQpjONwDWpHetbDvuEEopEzYyNQjVSnl9Cci22PLYpd2H0ZXjvMpvATo6
         KVW0PB5fNK7+jxUc+D7fe0Iy1cibWbqnNaKWjDe+aVhCBgwkl/Wk+Vzpx7i9+cxNYTln
         ZItw==
X-Gm-Message-State: AAQBX9cPMSY7RLOtbdJbzAAYaRmxiN04DCpgMUt10aJahveiVE0JXoco
        GiKAArMsIrrJCEBoyHcBPT4=
X-Google-Smtp-Source: AKy350YeUAb7t76TYhcHgvNYbchZjcQXwJZvGmf45PvpnT5B0CPhp8qcs3kbnzKThyBlwm+NB0PD5A==
X-Received: by 2002:a05:6402:1acf:b0:504:b592:ed06 with SMTP id ba15-20020a0564021acf00b00504b592ed06mr6669455edb.39.1681327128365;
        Wed, 12 Apr 2023 12:18:48 -0700 (PDT)
Received: from ?IPV6:2a02:3100:903d:3d00:b0e7:6bd7:f613:784b? (dynamic-2a02-3100-903d-3d00-b0e7-6bd7-f613-784b.310.pool.telefonica.de. [2a02:3100:903d:3d00:b0e7:6bd7:f613:784b])
        by smtp.googlemail.com with ESMTPSA id i11-20020a50870b000000b004bd6e3ed196sm7181974edb.86.2023.04.12.12.18.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 12:18:47 -0700 (PDT)
Message-ID: <29973c8a-2b14-3d0c-bee8-8aff36c265e3@gmail.com>
Date:   Wed, 12 Apr 2023 21:18:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
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
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v3 0/4] pwm: meson: make full use of common clock framework
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

v3:
- patch 1: move setting mux parent data out of the loop
- patch 4: add flag CLK_IGNORE_UNUSED

Heiner Kallweit (4):
  pwm: meson: switch to using struct clk_parent_data for mux parents
  pwm: meson: don't use hdmi/video clock as mux parent
  pwm: meson: change clk/pwm gate from mask to bit
  pwm: meson: make full use of common clock framework

 drivers/pwm/pwm-meson.c | 193 +++++++++++++++++++++-------------------
 1 file changed, 100 insertions(+), 93 deletions(-)

-- 
2.40.0

