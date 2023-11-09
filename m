Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3807E7297
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Nov 2023 21:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234652AbjKIUHF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 9 Nov 2023 15:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbjKIUHE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 9 Nov 2023 15:07:04 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E27444B1
        for <linux-pwm@vger.kernel.org>; Thu,  9 Nov 2023 12:07:02 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5a7eef0b931so15470597b3.0
        for <linux-pwm@vger.kernel.org>; Thu, 09 Nov 2023 12:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699560421; x=1700165221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JxfBT9XrSRT5nrDSafWJh9sd+I3zu8gAVwzWVP+isuk=;
        b=wRlxhK72w6O5c5iPkyqSco0awCEHjG8RKS1w691vXr5E5gHa1GxtFSK2UMBm0f7at7
         lbRNSpBebmSMpS/Deg5XJ8VvdZNuhIjegYWGU5ikllSTvlUEP8LSXQsd4dBfNaR+yNXK
         tPgTHRb1gaJ0cOAX643Ohba3mpPxbo8RCwnt1HpkiYrF5uJ1pGSnOHfiTueFWgE3Dqn/
         u88ZBAn2tAuicHiOPEuD/SPxw3WsKqTO2GpW/38AnZRFTS2lp1XLiPLHp4J5/tMyK7fw
         sHAwZ4aL2oq1uB08XwGLuEI+fXXa+7oK8w6n1R8PZVbltQoo1ZBbfMWh7vSR1ePzxy9a
         uEjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699560421; x=1700165221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JxfBT9XrSRT5nrDSafWJh9sd+I3zu8gAVwzWVP+isuk=;
        b=gtUqUk2WSmMjouQfBAPxCKvUvj8tM+rj0N4EchoBu1vvDM+H5J4qchWTmwosLz3O0V
         fXNJD0sf2r425R0rnW/HV/GuJFfOkx7ohHIzJdYSWBd4diA83o2hHNPRJdyVC2pp7bh+
         zEVbe1gaWiFsOv4DxxqO/EfWhQq91QYI7PwchX7hg0GnuTfNn/218gITnMhfzCDQzFEf
         0VmF4ORIqlhBdk1ik2oUOaEKdukgjM1fBLGxcFOyiGlC1pfjGWWTeDgy0vBtBsaaN2Ay
         C3O9usKzJNUaluOsMjWA8ZeHVMiehnKNHjI0pLG79Ab67Q2bDozOrGDyrpKMWfWvDtJl
         VpDQ==
X-Gm-Message-State: AOJu0Yy/S2k+68AMSZVUriWxH0xd5+TPwEbPRGCrwtCy67VOGFuTStXa
        qTFdlYcmnbAqmS2onSPXc/hE+scQofScC7wK+0GR8Q==
X-Google-Smtp-Source: AGHT+IEXBKt+FURrtNfddWlqR3gL5F6B4MyNTpLeCgYWcpg+lWu9UphB2hG1mn1lgkc9/kt9ZZeKnj4In3j2CaEDK+8=
X-Received: by 2002:a81:df01:0:b0:5ae:c35a:807a with SMTP id
 c1-20020a81df01000000b005aec35a807amr5649968ywn.48.1699560421299; Thu, 09 Nov
 2023 12:07:01 -0800 (PST)
MIME-Version: 1.0
References: <20231108104343.24192-1-krzysztof.kozlowski@linaro.org> <20231108104343.24192-4-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20231108104343.24192-4-krzysztof.kozlowski@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 9 Nov 2023 21:06:50 +0100
Message-ID: <CACRpkdbAwOfjbD_CjC4Aqi_A2+pghTBeWyV7mPMZv25BXMPStw@mail.gmail.com>
Subject: Re: [PATCH 03/17] dt-bindings: i2c: samsung,s3c2410-i2c: add specific
 compatibles for existing SoC
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Lee Jones <lee@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Nov 8, 2023 at 11:44=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> Samsung Exynos SoC reuses several devices from older designs, thus
> historically we kept the old (block's) compatible only.  This works fine
> and there is no bug here, however guidelines expressed in
> Documentation/devicetree/bindings/writing-bindings.rst state that:
> 1. Compatibles should be specific.
> 2. We should add new compatibles in case of bugs or features.
>
> Add compatibles specific to each SoC in front of all old-SoC-like
> compatibles.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Makes perfect sense to me:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
