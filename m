Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D540D6DBCF3
	for <lists+linux-pwm@lfdr.de>; Sat,  8 Apr 2023 22:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbjDHUk3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 8 Apr 2023 16:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjDHUk2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 8 Apr 2023 16:40:28 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5158CAF2A
        for <linux-pwm@vger.kernel.org>; Sat,  8 Apr 2023 13:40:27 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id dm2so4345900ejc.8
        for <linux-pwm@vger.kernel.org>; Sat, 08 Apr 2023 13:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680986426; x=1683578426;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zEDP43uZ98Y6T0PfhiJg3EwYN9keHU4o+RIDWqYy1sY=;
        b=dVMeSt+eSPiLW2eWTieLU2UDRathj7J7VKUZU4Zb4BLvKjD3cxiLj8B3dkfGTkpoc0
         StpDByiKdTLPKWw8QMkkc9/xCpwHsW6PemR2bFATWz0cRAE0dCZ8bGVBGU6gXe4OdvH1
         7R0XahQqzCOKP+RHsWQQOZlQmB4eWhMHhY7VDStwPrtWA31/2u+nQ2DZ9lJ6kRrLlkMw
         BoX9rLXGiGPNuaP3jjP1q+TMODME4Dm+4lJVQzs8dCE+WjQoAyDPs9/it5T1y4EO4zgd
         dAdZe6EvRrtEYKQuT/pZbM5x/17QhqG1R4Z882lkHzBUrWXtCMpPQhZ07+kXqRf+PQl8
         uVHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680986426; x=1683578426;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zEDP43uZ98Y6T0PfhiJg3EwYN9keHU4o+RIDWqYy1sY=;
        b=eMNtuUS5LNYsfcs9Ww0gwvGSk3Qjv6n+yHAWHg2sb8WHsvndqdLN22uItkJv9Szz3z
         sUh4EayVwKohPtJN8Nf0+GiNJRBXN9XKk7trCePiis1J5r0eUl44GFENMWnt77npRldu
         yR3pIrj29oWQCNf+NG3tGX3FUf10WSTsFIKEUC/4C6c6T5AiPHhNPPCENLZFtatx3IDM
         7vsOhbvLyX2VSPEDxHjAD/pDGgzfLoQgc+L1fsDJBRWKQsiAoy5S1ZMwXP+d75gSL1Q9
         j7u9sQ+YTLJzA/JgACjB1pPrJS2/93Hg+xiY7Cj/HbrqEZdIzLYsvgoFM0rp2Ea4ObCa
         W0AQ==
X-Gm-Message-State: AAQBX9cOaPh2MbTMheXAd5LB6wlrX1pT1XdMq4iH/SaGgvHv+uoIqnpy
        WMtjN+KCW1dxM1R+m2W3ot8=
X-Google-Smtp-Source: AKy350ZguJX/6bteV4qadzSTJAFN/QUvO2I50S8r3GS2AfUOppRv++5T6PHEgXCiRYouTunLKwLM6g==
X-Received: by 2002:a17:906:39a:b0:93d:1c2b:bd23 with SMTP id b26-20020a170906039a00b0093d1c2bbd23mr3678653eja.39.1680986425466;
        Sat, 08 Apr 2023 13:40:25 -0700 (PDT)
Received: from ?IPV6:2a01:c23:c57c:9500:b062:7c54:caa1:b5c1? (dynamic-2a01-0c23-c57c-9500-b062-7c54-caa1-b5c1.c23.pool.telefonica.de. [2a01:c23:c57c:9500:b062:7c54:caa1:b5c1])
        by smtp.googlemail.com with ESMTPSA id m8-20020a50d7c8000000b004fe924d16cfsm3229977edj.31.2023.04.08.13.40.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Apr 2023 13:40:25 -0700 (PDT)
Message-ID: <275c72a8-b9cb-e675-f1c0-4da658c3f98e@gmail.com>
Date:   Sat, 8 Apr 2023 22:40:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
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
Subject: [PATCH 0/2] pwm: meson: make full use of common clock framework
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
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

Heiner Kallweit (2):
  pwm: meson: make full use of common clock framework
  pwm: meson: omit video/hdmi clock as mux parent

 drivers/pwm/pwm-meson.c | 159 ++++++++++++++++++++--------------------
 1 file changed, 81 insertions(+), 78 deletions(-)

-- 
2.40.0
