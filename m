Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4AE635B95
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Nov 2022 12:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237328AbiKWLYX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 23 Nov 2022 06:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237373AbiKWLYA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 23 Nov 2022 06:24:00 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1F4102E61;
        Wed, 23 Nov 2022 03:23:28 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id ud5so42051429ejc.4;
        Wed, 23 Nov 2022 03:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8E3HfKqpI7OPKMpyZd0aAajsv0bkMn9cWxEfRq/Jexs=;
        b=S75Rq8lR46tMXia66z0bag4+iCEPjiOF29vJ4f/d9XmTqxByrmRDlJEY4PEHfujyr7
         3iSruSGx+Od/ROcQpcRX5L5P2cTbwM+v+F+vwC4SwkVBxQwXe5u3Y/rFpf3d06ryu/tu
         niIZV05v7O7fTlS/fjkCLSWkktRHWiRGT2jPTd9oiQhqfieNgOZcMTkgf6MwrMJXLale
         c1x4xo36zcBnAebY6q85YVJQxFtc6asFl1SnmkR6k4CaWCLV5HsO7YnouSORPhVk752+
         lvWFDUUEn9oxMFlJrcd3kdfqxad4Z1MY4wfqrv8naYXI6gpO7nnBrIzTsaY+fhmqH4xb
         wigA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8E3HfKqpI7OPKMpyZd0aAajsv0bkMn9cWxEfRq/Jexs=;
        b=d2BUEFfkLDN+IIadQ3YEbK+eoZYZUv1kXcI0wuJekKebcaT2JOchbTQtLMTZlJz5FH
         74i3erNTM5Jocw4qtPDAvmksFDFYCLAdF8hYNrW2K7JiaiCRujCp+MKCL2dLu03jlSlT
         tv2bH9E60W4gXvNpiWQNRQHZOdbaD2T0mxX+biBXxhhRwpoPWAFx5Gf3Ers9f+GXmwrt
         L3W9s9iCWfAd+O+qDFGj/kDiGNeennlIZayMO1w+P9Klc7h8MtIptXEJy1VjUFYCeIQn
         BQ9x8E8M2SibftWDjR7GdS5xEHd/eU/X1jP420Xy6KbjE2584/Nu0Ia8E/srlBJ9c1FL
         E3yw==
X-Gm-Message-State: ANoB5pkfRukJP5+UTTevgEJVFOxmKd3hep2f5SaJgQRHEYMjxtdiyaEp
        NyN+pHt8Vc8tCJs/Z1bJvbk=
X-Google-Smtp-Source: AA0mqf6JNLeF8BQxBTQEN4OYB4XAlsusO8D5L5Frr6SYljvV1WXopKgkTBJpsD0A7oGpJeeO7LpjHQ==
X-Received: by 2002:a17:906:bcc1:b0:73d:715c:5730 with SMTP id lw1-20020a170906bcc100b0073d715c5730mr23101781ejb.293.1669202606864;
        Wed, 23 Nov 2022 03:23:26 -0800 (PST)
Received: from localhost (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709065a8900b00773c60c2129sm7187189ejq.141.2022.11.23.03.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 03:23:26 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: pwm: renesas,pwm-rcar: Add r8a779g0 support
Date:   Wed, 23 Nov 2022 12:23:22 +0100
Message-Id: <166920257255.1455112.3556103275813437388.b4-ty@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <2d1732595327307080c57e201a7f029f8adeabf3.1669047149.git.geert+renesas@glider.be>
References: <2d1732595327307080c57e201a7f029f8adeabf3.1669047149.git.geert+renesas@glider.be>
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

On Mon, 21 Nov 2022 17:13:02 +0100, Geert Uytterhoeven wrote:
> Document support for the PWM timers in the Renesas R-Car V4H (R8A779G0)
> SoC.
> 
> Based on a patch in the BSP by CongDang.
> 
> 

Applied, thanks!

[1/1] dt-bindings: pwm: renesas,pwm-rcar: Add r8a779g0 support
      commit: 5719efcc5abb34ceb47b03e58709d99713f80db1

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>
