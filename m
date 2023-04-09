Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82AC56DC085
	for <lists+linux-pwm@lfdr.de>; Sun,  9 Apr 2023 17:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjDIPQA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 9 Apr 2023 11:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjDIPP7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 9 Apr 2023 11:15:59 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C8A3A8D
        for <linux-pwm@vger.kernel.org>; Sun,  9 Apr 2023 08:15:57 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-504718a2265so1908417a12.2
        for <linux-pwm@vger.kernel.org>; Sun, 09 Apr 2023 08:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681053356; x=1683645356;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Al1LHFrT9+plpcBLVRezELznyWJyVoaJnaezPUgcF4=;
        b=WZTnRVtyyCX3XAI/9IXuHB3b6RrNv/SsBkmFPmc68C/MltXlia1eje7s30qBBY9oHF
         su40ISV+YoCe66oWNBpN+v4LMYFz9lcMinZaofFaHmazM4RRgLFicNGjlhTMeD8XmST2
         cGQY65wOGOzpcs2qQSQ1aTpqWWQCP6xDODafMAx8DDWSkDQ7NydbfyIhhlrU+V9zzLHp
         5j/FdwFCeE2AZR1i9LzmTMTgZkTSORCw5spZxcizhxfQIboiqxCU4r0M7erSwL/hRfZQ
         v5ddtTUKO63fhTB3cI1SuqIl/Hvj5KicbnOS5WLNjh8KQcpyJsdtllAXFpDuwJayGx6G
         qRVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681053356; x=1683645356;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5Al1LHFrT9+plpcBLVRezELznyWJyVoaJnaezPUgcF4=;
        b=tIN0IQwq04SD3yJgOHUDKqFzgpygpk5E6Omsd64w1kuiWwwE0skz/T+MnXzM17tvHc
         BnCYst4sucKkckKyoAf3tnK8BcpwSUDFdYlzuVJGNz3M8BJfM74TpqzxxemYhCtEFbKf
         G2lKpp7NpJfNbQJ8b3WnjpzNxJGzpFmzlPaeAYJSzVTqB/dyw1MObekP4YFHazg3kA/d
         VbHi7BgB1oK3P+msAGADXRCja1O3q3D+tkMsh4rpluFiDvBcTQ+f5pSuLDHmSmpf7wbT
         FhEKs2r2uq9TttRCep+dJzgyfdeXZGa1/LsFsBQzuu+2CWFXQLzoYNSB/13ssV4Irp0D
         uczA==
X-Gm-Message-State: AAQBX9eBdtW7lUrfh/bEdNI1XLCtltMIrIHBZw2dI212MM+PZULtx4Kb
        vs7A/1wjmhSD0owUtZHrM/E=
X-Google-Smtp-Source: AKy350b4nVjPPZSIcozRDhxLFOvnIY8jbn9Nshb1z6he5aS2hFU/rxY9WWwskx+5UiANKmuW/wsEcA==
X-Received: by 2002:a05:6402:746:b0:4fd:2b13:b20e with SMTP id p6-20020a056402074600b004fd2b13b20emr3592714edy.30.1681053356184;
        Sun, 09 Apr 2023 08:15:56 -0700 (PDT)
Received: from ?IPV6:2a01:c22:7ab2:4700:19e6:ecdf:3dcc:c731? (dynamic-2a01-0c22-7ab2-4700-19e6-ecdf-3dcc-c731.c22.pool.telefonica.de. [2a01:c22:7ab2:4700:19e6:ecdf:3dcc:c731])
        by smtp.googlemail.com with ESMTPSA id i13-20020a50c3cd000000b004fa012332ecsm2583301edf.1.2023.04.09.08.15.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Apr 2023 08:15:54 -0700 (PDT)
Message-ID: <ffc3e4e7-b2ea-1a56-4fff-6554ad3775c0@gmail.com>
Date:   Sun, 9 Apr 2023 17:15:52 +0200
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
        linux-pwm@vger.kernel.org, Jian Hu <jian.hu@amlogic.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2] pwm: meson: fix axg ao mux parents
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

This fix is basically the same as 9bce02ef0dfa ("pwm: meson: Fix the
G12A AO clock parents order"). Vendor driver referenced there has
xtal as first parent also for axg ao. In addition fix the name
of the aoclk81 clock. Apparently name aoclk81 as used by the vendor
driver was changed when mainlining the axg clock driver.

Fixes: bccaa3f917c9 ("pwm: meson: Add clock source configuration for Meson-AXG")
Cc: stable@vger.kernel.org

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pwm/pwm-meson.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index b5c746fab..0fe0400c2 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -381,7 +381,7 @@ static const struct meson_pwm_data pwm_axg_ee_data = {
 };
 
 static const char * const pwm_axg_ao_parent_names[] = {
-	"aoclk81", "xtal", "fclk_div4", "fclk_div5"
+	"xtal", "axg_ao_clk81", "fclk_div4", "fclk_div5"
 };
 
 static const struct meson_pwm_data pwm_axg_ao_data = {
-- 
2.40.0

