Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1037665C4
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Jul 2023 09:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234532AbjG1Hu2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 28 Jul 2023 03:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234501AbjG1HuU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 28 Jul 2023 03:50:20 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9E135BF
        for <linux-pwm@vger.kernel.org>; Fri, 28 Jul 2023 00:50:11 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fbc63c2e84so20199575e9.3
        for <linux-pwm@vger.kernel.org>; Fri, 28 Jul 2023 00:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690530610; x=1691135410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DDrQSF4flbfX31MTNsZ15td23C3i0hNJdQ7UI0vCA3I=;
        b=DJXTLmy58DH82+ndYnRhovf0F46i4Qt08gyosVKYjJaphIunwDUwAzldq17njcyipw
         26pLbTBaOdB3JYXsJoFdcXPWy7flzVbsdlKiZEfyzzYj6AcyQPQ29RjWE8eTLmbJY86P
         dYK718jc4GtH7GdMCLY1g4FhRK8c0X0OtY2m9r16b79F5J69pOb7genW+sPoMKqvVIR6
         /MIAXbW+qxMPhX9L4SEsn4ulVqwoztDabTSdLzcSnBN1lcF7xBmLmZjDd3dUWPQDnfZU
         ObWglzNlQBifg+6WGmKCl+PQN8NlOft/lPIDp8kOvQHi8ZWimM/PYJYj8BUQLarguzWD
         A6+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690530610; x=1691135410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DDrQSF4flbfX31MTNsZ15td23C3i0hNJdQ7UI0vCA3I=;
        b=Z4495hPD7ol3Epa1XILJf8Q3L3rYpdDJ7JTdvEmIMtQWwyXB7NfJml9VBhQjXYr5W1
         Cg26VP5nupBdmQS6xdaB8onZOLrAoQ6gPjzYAWVEiHpLCQ6gmHCG6V9KyE686U/wVlTT
         ga4K0SNyn1L0Mudo1I5I9fMY9YbHXWNAfP+Mdmg6EAQvZxKId/191nvQNExEVLoNV5DN
         NZmTTbpzOQ4ixdIIAGC3BB4TVzUTdi5WwxvOSAqYg9k33aXLTAuIWI78b/h8Fcclwmlq
         6Ufx6eAw5SdLyeO3FpN0PKrYnMtfdh6IHxXamcecePHHNFqD79xlhrYUdqVvtm/ggTvo
         4N3A==
X-Gm-Message-State: ABy/qLa6Op+HaNjUPxM8+vCfr0rKImNv+gbhPhy8tYU01c75JE//SJAH
        E1XHGGBZCrDgZG1+Hnjx3J9tmf4YtLU=
X-Google-Smtp-Source: APBJJlEgSiKQeIzrK/jf6155faui04e89WIa1lf3pSVZA/JOpzJggqhsijVHEfTfWO5PmXty8T+t1g==
X-Received: by 2002:a5d:4533:0:b0:317:69c7:98ad with SMTP id j19-20020a5d4533000000b0031769c798admr1181655wra.3.1690530609932;
        Fri, 28 Jul 2023 00:50:09 -0700 (PDT)
Received: from localhost (p200300e41f1bd600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1b:d600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id y8-20020adffa48000000b003159d2dabbasm4080107wrr.94.2023.07.28.00.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 00:50:09 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, kernel@pengutronix.de
Subject: Re: (subset) [PATCH 1/2] pwm: stmpe: Handle errors when disabling the signal
Date:   Fri, 28 Jul 2023 09:50:07 +0200
Message-ID: <169053057431.3515253.3807570644936028334.b4-ty@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230714214519.2503468-1-u.kleine-koenig@pengutronix.de>
References: <20230714214519.2503468-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


On Fri, 14 Jul 2023 23:45:18 +0200, Uwe Kleine-König wrote:
> Before the pwm framework implementedatomic updates (with the .apply()
> callback) the .disable() callback returned void. This is still visible
> in the stmpe driver which drops errors in the disable path.
> 
> Improve the driver to forward failures in stmpe_24xx_pwm_disable() to
> the caller of pwm_apply_state().
> 
> [...]

Applied, thanks!

[1/2] pwm: stmpe: Handle errors when disabling the signal
      commit: b2c71e9f8dd0d023a847f6c38f9a83c0949ec01a

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>
