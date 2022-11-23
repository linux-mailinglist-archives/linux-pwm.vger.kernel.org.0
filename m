Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B8C635B90
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Nov 2022 12:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237353AbiKWLYY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 23 Nov 2022 06:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237379AbiKWLYC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 23 Nov 2022 06:24:02 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A8910AD2E;
        Wed, 23 Nov 2022 03:23:29 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id v8so13367741edi.3;
        Wed, 23 Nov 2022 03:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FrAt4ByWk4XAwGofuv5blZvYxRxRqUOIcR/LfPMrukE=;
        b=DKZKp6xlz9rWJ+UM6jAAsNLpfX2wosD+PrhfM0G8DFIFddDWKR4ky728VwpD+HPetK
         6hHh+0kRT2mkXK/XnA7wVHUGnlkmSky/bUtoBMVApvH+6E4ZrnXiC5ydlBa7ApfK/doJ
         pRpWt+1cDYxsvFn+blmW6PkV6IYdR1yn5oqmxhGYLfy1UUVretcj+XqcL4fZ/JZWAO5F
         UQYZOD+Hx3QGCXWfwVqfiIuELEUMpEUx2GAZlNiA0/157zCgDkqJEWhsBukCVj+OvkrR
         tZznso/GmMVhXRGN4YKB4Yg8NQR+tRMxOj7sCb6WjFWqhqkZtAMBqN/jfUhVd4QBlFBD
         8a7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FrAt4ByWk4XAwGofuv5blZvYxRxRqUOIcR/LfPMrukE=;
        b=eItCa9mlT3USkQmMW6MaDaf2Y0Y1OIldajVtF7GnyFWJkNT0mfsJrK9HtL8fn9VaGy
         X5MH9orDiy8lvqEu8ieag6jkUhp9eeu/9xNd/i6/CoBDU2qSTKAkM9Ctx6NZMBG49Zox
         Pr6A8aXhc0emCaLCfHmhfWwtxd4qcO2dVLkJGO7GXmCQkTzdc9Y//JGftcRrUjk/CSZY
         Edn4kCuB6M+tzE2q4syhWjGHVbGLFivwvoVyKtNlWvFVupSdXZK2mPwShjad43bb7IiC
         xQRgXrIttLns2idu55CKNNiv/TmHljFgUj00eqoCuuCd4Sj3J+ajlmfByKKAwdrc1zJ1
         q9hQ==
X-Gm-Message-State: ANoB5pl8M29kymNXd1r/wVqpDoyFZCNXO6cL99/K2EZeejTThiHqrVo7
        OD8oo+mIoTQziyLrv1QWTKo=
X-Google-Smtp-Source: AA0mqf6KznzDxEgmlgssmc2SbGZA3fYhuwpdfA/3s9yH2f9S55qeAEfEhefQdDBif0kSY2c6jAbIPw==
X-Received: by 2002:a05:6402:1381:b0:468:5b78:6381 with SMTP id b1-20020a056402138100b004685b786381mr12501363edv.373.1669202607939;
        Wed, 23 Nov 2022 03:23:27 -0800 (PST)
Received: from localhost (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id la1-20020a170907780100b00787f91a6b16sm7057757ejc.26.2022.11.23.03.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 03:23:27 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: pwm: renesas,tpu: Add r8a779g0 support
Date:   Wed, 23 Nov 2022 12:23:23 +0100
Message-Id: <166920257256.1455112.10323739493176778611.b4-ty@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <ccdf2ccb5aeb9329d959599069d60177fe34e892.1669047191.git.geert+renesas@glider.be>
References: <ccdf2ccb5aeb9329d959599069d60177fe34e892.1669047191.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, 21 Nov 2022 17:13:42 +0100, Geert Uytterhoeven wrote:
> Document support for the 16-Bit Timer Pulse Unit (TPU) in the Renesas
> R-Car V4H (R8A779G0) SoC.
> 
> Based on a patch in the BSP by CongDang.
> 
> 

Applied, thanks!

[1/1] dt-bindings: pwm: renesas,tpu: Add r8a779g0 support
      commit: 50315945d178eebec4e8e2c50c265767ddb926eb

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>
