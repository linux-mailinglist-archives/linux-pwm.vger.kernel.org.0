Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A74D2A4E21
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Nov 2020 19:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbgKCSQp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 3 Nov 2020 13:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbgKCSQp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 3 Nov 2020 13:16:45 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D0CC0613D1;
        Tue,  3 Nov 2020 10:16:45 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id t22so8937366plr.9;
        Tue, 03 Nov 2020 10:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:thread-topic:thread-index:date:message-id
         :references:in-reply-to:accept-language:content-language
         :content-transfer-encoding:mime-version;
        bh=k0DG4sb8XOtJOwN6TLhr+5qsFzs3ayb+63KIAEg2F6g=;
        b=pZIDUWHuqmi0r+lNSw5OaFLd0XW/nVZVW2NTNpJSY9bPoYhh3CTe2BTZn3Exc/WI99
         pfcwlwj5DnNgYX+EZRc8qS3UMjZVYzwQv0YCi5Q3JacETXmQaFnh7Bgab54NUYuRKN4s
         IopkMD1pT+jRpbo+pVQmPJlQ9PyOnIgqNMCkAtmdDTWgQxX1wTtcZ6wiclbmB4464JKd
         0nQW2djN9+lh3fevKAZtAhNp7OY1psFGkbF/eknVX6krJWiOhlhC78dr2FysjP/n9TyT
         5bQ5r8r/78dra0KqKv46K4lgofN3lpwhCcYIRCSpA+fZMDG2s4yPGyBj+p2qZbW08eeC
         u98g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:thread-topic:thread-index
         :date:message-id:references:in-reply-to:accept-language
         :content-language:content-transfer-encoding:mime-version;
        bh=k0DG4sb8XOtJOwN6TLhr+5qsFzs3ayb+63KIAEg2F6g=;
        b=sZ4KkxDejlk81/Kv8AV3eGGdP9DpEnSy0v1G+wwY2TxFkOuJspzaat5TjXRmjX0i+T
         JxqaJk7WkujhSFqMPaQvxebFr1sc+5ocPaaWswWtXdsfieYLRVlYl0AQ0sBr6y4o5UAt
         8Pxp8n7Nx+unrP41uz+rYWiifB16fXAmQMfCCOwnUgcoFtXZg7dVy9JGCmxMvli6ugzw
         xc0XRet+exjpgI6KVKBGtr9AtOehbKoQGMgM/GRub8zv8QWKHRVJ3QIervK2h28ggfvH
         1jnAWUVDwZqM9yK5/85YtzsabFMdCKd9NQhVm2otfLlFUJUoNPFwV/ga86JJC1M+yQSK
         xV8g==
X-Gm-Message-State: AOAM53266XfalNwIc6xOqiix4jCCFE8Dwa4FJhlBMRCFjbZmAd4RvDS2
        mzCkY74f0BXl0BYUWbfi2iOOQLTQzmRejQ==
X-Google-Smtp-Source: ABdhPJy/3gdywHqjCB7waXp0Y7ytzLjBbiYVOp4zjKQvoTUg3oKoSphU2GPctv3qAoe+Et3YumYEAA==
X-Received: by 2002:a17:902:be10:b029:d5:ced2:cc20 with SMTP id r16-20020a170902be10b02900d5ced2cc20mr18834350pls.25.1604427404853;
        Tue, 03 Nov 2020 10:16:44 -0800 (PST)
Received: from SLXP216MB0477.KORP216.PROD.OUTLOOK.COM ([2603:1046:100:9::5])
        by smtp.gmail.com with ESMTPSA id c2sm9075705pfb.196.2020.11.03.10.16.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Nov 2020 10:16:43 -0800 (PST)
From:   Jingoo Han <jingoohan1@gmail.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>, Dan Murphy <dmurphy@ti.com>,
        Pavel Machek <pavel@ucw.cz>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Han Jingoo <jingoohan1@gmail.com>
Subject: Re: [PATCH v3] MAINTAINERS: add Dan Murphy as TI LP8xxx drivers
 maintainer
Thread-Topic: [PATCH v3] MAINTAINERS: add Dan Murphy as TI LP8xxx drivers
 maintainer
Thread-Index: AWsxNDgwBJ/rfWbefi0QBZZ1bPG9z9cBsnfo
X-MS-Exchange-MessageSentRepresentingType: 1
Date:   Tue, 3 Nov 2020 18:16:35 +0000
Message-ID: <SLXP216MB047756F8B2B3BB88227BCD62AA110@SLXP216MB0477.KORP216.PROD.OUTLOOK.COM>
References: <20201103162832.14085-1-krzk@kernel.org>
In-Reply-To: <20201103162832.14085-1-krzk@kernel.org>
Accept-Language: ko-KR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator: 
X-MS-Exchange-Organization-RecordReviewCfmType: 0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 11/3/20, 11:28 AM, Krzysztof Kozlowski wrote:
>=20
> Milo Kim's email in TI bounces with permanent error (550: Invalid
> recipient).  Last email from him on LKML was in 2017.  Move Milo Kim to
> credits and add Dan Murphy from TI to look after:
>  - TI LP855x backlight driver,
>  - TI LP8727 charger driver,
>  - TI LP8788 MFD (ADC, LEDs, charger and regulator) drivers.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Dan Murphy <dmurphy@ti.com>
> Acked-by: Dan Murphy <dmurphy@ti.com>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Acked-by: Sebastian Reichel <sre@kernel.org>

Acked-by: Jingoo Han <jingoohan1@gmail.com>

Best regards,
Jingoo Han

[...]
