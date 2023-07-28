Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8DC7666B2
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Jul 2023 10:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234788AbjG1IQC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 28 Jul 2023 04:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234712AbjG1IP7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 28 Jul 2023 04:15:59 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24989198A
        for <linux-pwm@vger.kernel.org>; Fri, 28 Jul 2023 01:15:57 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-98df3dea907so250421266b.3
        for <linux-pwm@vger.kernel.org>; Fri, 28 Jul 2023 01:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690532155; x=1691136955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=luEtBSD5i6niiqesHv04zZ5IrUTPE0FOO01DxpI9kLs=;
        b=oyE3Ju2TqnEuKEdRc0iAOtWeDmSX+9OUZb//OHbYor3emEZchx69TP2eghCmucH4g/
         Rqj3tGHooJH9tWDcffcNJjmpcBEsiLQofRz0tAkDG4VinIGtkInjhjmcVHzZkjed36Yh
         U9Oi3yqlCwKPiQXbEJejkE/CeieCgbVFWgJfZnX0Y5WuHHbSDOZQkbzkbrAxkbIyfsuu
         TAyiiCW88C3BA9UrIpc8O/Sysbnn0g5vpZYiKrlnSuaOWovfXBaROh3P9sW/aiqYF6yV
         EgSo6J5r54onXselt5GAbLiIB1UxNPrOyhFBtbZfz1Sc7XOoVCdz/bpeiT3/jaii+nx8
         noaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690532155; x=1691136955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=luEtBSD5i6niiqesHv04zZ5IrUTPE0FOO01DxpI9kLs=;
        b=dj1tb57/tlSBcR+oQE7pIdHqxKT4RmLRa/mXddGX47A2E2DXJKi+LnEqlDEU1oj+tZ
         YzCMuskXZvrFC+eRxYYzX3gW9BNNyeFmcQ6NPaL47xC/zntkAQsP8R2MUDalXD4GVCa+
         4aZvLlruL8Q+EAIpnhFOZVzv6x5SXNBodn+6bsWgafCeCDfeZWBrIokbQWj8WPb7ItgB
         8fAARhEswBxkkQ7NoYbNIjZeNCGnH/wQBN/NRX4MSFGlNpZgbcvJVGnKTwRiDuL/kYxn
         RfXlxlrxyC5IDfh6zK6q9uJzGnFHzzi5V8RkOY5S0F/WESnzttYqOfXzH849boJFDDgZ
         dA2g==
X-Gm-Message-State: ABy/qLZ94K23T49dWM/WM9dmszD5ijdWKwQ2hNtvAD9kEb4CGcQnfZ2z
        wqhqdGZkIEr7joyrMhxqr4Q=
X-Google-Smtp-Source: APBJJlGZf2zibPIcMSN7jAJ5LY/cR8/D2NlXcE5JN8Mqi9dMU8rPNlVvG1lhbmh4V5dz2Px6aE83sg==
X-Received: by 2002:a17:906:77d3:b0:993:f4cd:34b3 with SMTP id m19-20020a17090677d300b00993f4cd34b3mr1302328ejn.43.1690532155404;
        Fri, 28 Jul 2023 01:15:55 -0700 (PDT)
Received: from localhost (p200300e41f1bd600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1b:d600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id by24-20020a170906a2d800b00993b381f808sm1751804ejb.38.2023.07.28.01.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 01:15:55 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH v2] pwm: atmel: Simplify using devm functions
Date:   Fri, 28 Jul 2023 10:15:53 +0200
Message-ID: <169053214868.3516997.12448597572019188130.b4-ty@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230728081105.595161-1-u.kleine-koenig@pengutronix.de>
References: <20230728081105.595161-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


On Fri, 28 Jul 2023 10:11:05 +0200, Uwe Kleine-König wrote:
> For all resources used by the driver there is a devm variant to allocate
> these. This simplifies the error path in the probe callback and allows
> to drop the remove callback.
> 
> While at it also use dev_err_probe() to compact returning an error.
> 
> With the remove callback gone, there is no user of driver data left, so
> the call to platform_set_drvdata() can also be dropped.
> 
> [...]

Applied, thanks!

[1/1] pwm: atmel: Simplify using devm functions
      commit: b22bb0d6a828b4eab579056647d2f362ac116cf2

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>
