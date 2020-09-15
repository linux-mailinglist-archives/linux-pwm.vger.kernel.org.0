Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E531269A94
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Sep 2020 02:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgIOAnr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 14 Sep 2020 20:43:47 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:34782 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgIOAnq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 14 Sep 2020 20:43:46 -0400
Received: by mail-il1-f195.google.com with SMTP id a8so1422032ilk.1;
        Mon, 14 Sep 2020 17:43:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=UNo7mnvbrxfEkc0MpSN1laoGb3kvFf+1FihcAh2kuwA=;
        b=czHw3kjO2bsqlXToKgdCZvxcClIlBc6OUWDEi/UCyq4pbqUmdjD0BwQ/SdAO8lk/8R
         PGS6kcvPPooj8p+IUJrFMYR7SQr4MH0DXPQ8SjzEXnLPnFB9o6KbrfoT8Za4utaHqg4C
         NpQnG7qBINZrX3sGvIJ5cwIVGIac9Folk1aUpHmolmZg1n3SFwpd28ESvYpdmkRrxq7+
         i4vIAtm/mMCVGB+EgCWnkx7P5yvcZroDnKlfYhbAsgN9lK/dw1tbjQhKiZdC4r0e+r4P
         m7Oxa1FBj9Z8zbhzvmgd7RjEsfSLjgK7ypY+clhMHHkcxwlC1YbTWVgd0q+eC5899OEp
         JrqQ==
X-Gm-Message-State: AOAM53386ZvXI1MEIRx86j21TyvWdJRzWZQC+C/YT7NImr1LRuFxnZmR
        /9fFji/5/3epQFESbG76HMkRHkI+KIRE
X-Google-Smtp-Source: ABdhPJxzFLfpkXRw4xeAxrjp/JRY1XR9O5cts0wBuIhefTxqHs0fAUX8/qOZkEySJsYxiU3gLAuz7g==
X-Received: by 2002:a92:7711:: with SMTP id s17mr6292866ilc.236.1600130625930;
        Mon, 14 Sep 2020 17:43:45 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id w15sm7796085ilq.46.2020.09.14.17.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 17:43:45 -0700 (PDT)
Received: (nullmailer pid 593532 invoked by uid 1000);
        Tue, 15 Sep 2020 00:43:40 -0000
Date:   Mon, 14 Sep 2020 18:43:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-rtc@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Daniel Palmer <daniel@0x0f.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Lubomir Rintel <lkundrak@v3.sk>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, allen <allen.chen@ite.com.tw>,
        Rob Herring <robh+dt@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Mark Brown <broonie@kernel.org>,
        Andreas Kemnade <andreas@kemnade.info>,
        Stephan Gerhold <stephan@gerhold.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org,
        Sam Ravnborg <sam@ravnborg.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        linux-pwm@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Josua Mayer <josua.mayer@jm0.eu>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v2 01/10] dt-bindings: Add vendor prefix for Netronix,
 Inc.
Message-ID: <20200915004340.GA593474@bogus>
References: <20200905133230.1014581-1-j.neuschaefer@gmx.net>
 <20200905133230.1014581-2-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200905133230.1014581-2-j.neuschaefer@gmx.net>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sat, 05 Sep 2020 15:32:21 +0200, Jonathan Neuschäfer wrote:
> Netronix, Inc. (http://www.netronixinc.com/) makes ebook reader board
> designs, which are for example used in Kobo and Tolino devices.
> 
> An alternative prefix for Netronix would be "ntx", which is already used
> in code released by Netronix. It is shorter, but perhaps less clear.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
> v2:
> - No changes
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
