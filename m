Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D04D46E0685
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Apr 2023 07:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjDMFsJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 13 Apr 2023 01:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDMFsI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 13 Apr 2023 01:48:08 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1374490
        for <linux-pwm@vger.kernel.org>; Wed, 12 Apr 2023 22:48:07 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id z9so7501144ejx.11
        for <linux-pwm@vger.kernel.org>; Wed, 12 Apr 2023 22:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681364885; x=1683956885;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=loG6/nNlZHds9iDZ/llqwsKTKK0tTKbPN/EvQ2kHqi8=;
        b=rZNKWEG+lBr67Y7w6dmDQo9WQ4ViFJd8IliYGaXFTnRwCVhFBEOPGoNBjUCjE6LNhm
         AvFWYIoX+BTMXe4xHmIVOg/mGVc7gLagkQFG8F7GUHHIPKMWJTCNGgwp2PaGILAfAL44
         8hzIEyi4KQWv919RIpUwNzmt4dSdXdZC6b0Hn2SyGfeUBqmhueWkX9drFvelayS3Jqpz
         p8TE2Kd4IkcLmrYe3HSQ+Jii9aaB6/cGPRVgRUUHeEcGHHB8oOuX0oWwE1BXdvLC07HY
         l+j2DrFS0fiDvEueAordmAdK+/1/kqML09zHZhDSJIEYmZL81WPrwlW+DuLdKJ5fd8SU
         Xt+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681364885; x=1683956885;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=loG6/nNlZHds9iDZ/llqwsKTKK0tTKbPN/EvQ2kHqi8=;
        b=APvO5PoSJxNdpbVnqFEofSCbfGbiLFLBhXHVdZpLzvmBWVS2jl8GE4nbvnU37j5ulU
         Fq3uzUlm+RzFUaQJ2gosaXeOUb/zR2s+8ILgCtyix7Kn6el2ZRTx+q0Ehu0IiNcOAZbU
         RlUH1eU79SLGqor2d9M5STBS7TDR/+Pr93DYJGl8F6nFfH1IZDeoICewJXLBTetAigqX
         xDbwVblrpWeTrYEOSOmsZ403+8nDQxsJ/6hrHfXCrXd8mJfiTiZlABNTuR+9/y88qBwD
         CMBJ/qW1GQE9SG5PCOYq9DklkgnQDvMrpRQnHZMiWBBD99etzwdhPcl/fEIe/vf21IkB
         wG6g==
X-Gm-Message-State: AAQBX9f/RaXFRhym7xi7uCFnQJKg3rR7vw7s3s2FvkTWeirFFzqOzvwh
        7jBnnX+jeHVptjxUJA1iyeU=
X-Google-Smtp-Source: AKy350aJMK6ch3QmrVjXCt4gPQEI8VdaDXF4Sa0VlTOe1fwE4sekT0JzPwqqE3LqHXkVJ/3SC+XYYA==
X-Received: by 2002:a17:906:3c16:b0:933:be1:8f4f with SMTP id h22-20020a1709063c1600b009330be18f4fmr1343030ejg.9.1681364885412;
        Wed, 12 Apr 2023 22:48:05 -0700 (PDT)
Received: from ?IPV6:2a01:c22:738e:4400:9dd0:adc5:d6d8:61d8? (dynamic-2a01-0c22-738e-4400-9dd0-adc5-d6d8-61d8.c22.pool.telefonica.de. [2a01:c22:738e:4400:9dd0:adc5:d6d8:61d8])
        by smtp.googlemail.com with ESMTPSA id dc14-20020a170906c7ce00b0093237bd4bc3sm398805ejb.116.2023.04.12.22.48.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 22:48:04 -0700 (PDT)
Message-ID: <9faca2e6-b7a1-4748-7eb0-48f8064e323e@gmail.com>
Date:   Thu, 13 Apr 2023 07:48:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v4 0/4] pwm: meson: make full use of common clock framework
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

v3:
- patch 1: move setting mux parent data out of the loop
- patch 4: add flag CLK_IGNORE_UNUSED

v4:
- patch 2: improve commit message
- patch 4: remove variable tmp in meson_pwm_get_state
- patch 4: don't use deprecated function devm_clk_register

Heiner Kallweit (4):
  pwm: meson: switch to using struct clk_parent_data for mux parents
  pwm: meson: don't use hdmi/video clock as mux parent
  pwm: meson: change clk/pwm gate from mask to bit
  pwm: meson: make full use of common clock framework

 drivers/pwm/pwm-meson.c | 201 +++++++++++++++++++++-------------------
 1 file changed, 107 insertions(+), 94 deletions(-)

-- 
2.40.0

