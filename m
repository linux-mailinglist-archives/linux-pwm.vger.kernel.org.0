Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D068511A5E7
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Dec 2019 09:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbfLKIdf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Wed, 11 Dec 2019 03:33:35 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46932 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfLKIdf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 11 Dec 2019 03:33:35 -0500
Received: by mail-ed1-f65.google.com with SMTP id m8so18639328edi.13;
        Wed, 11 Dec 2019 00:33:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HzQhBjl4CEATxmwnIgxUg2g0u1Z69db5jVtArs+GAuc=;
        b=dQRppAsGdy3FvauCVF7oYCrZHl2I79rgZuPJixQwb4C5MoZZyaEyIBUsVRdPfqbxnU
         xHvrBCtCUZkSdJw7ivlikRK4LrKHAjrZC2/+QVci0YUwhCQHqi80Zw8jxpOMznTnrUYy
         YBcg3r+7KDWSwQI1oihAooUVaRIJl/82wd7zSSMvK3D+qi42a4PzkccRo3fNxTyeYkEe
         vWgYZ5/GXBSaF2lZNzFsOKGPPnP6En3vq1RyUMDjC+Ho1LIitEkT+f98ukzQheyq+xto
         jQb9YRu/uJmLvcIeY//ekghPAtVom0ckfVpbwomS194Cm5ycV8oPChQTj81QqmmJEWNl
         CHqQ==
X-Gm-Message-State: APjAAAVyD03+ZwIcumqlYlcHnrCmyb6A0bLQ4vR+bjI/jG9vOHZFVvnN
        Fc4ORy6zCZ+uYSuIWoAAM7kxMWDWPx0=
X-Google-Smtp-Source: APXvYqzwQTuYd/TjOPWeR3KKV7am/bZZPm2uZWfhkZtV7xZYTGc/D59x8oNVY8mQByduPUhvCHkP0w==
X-Received: by 2002:a50:ce56:: with SMTP id k22mr1969229edj.34.1576053212561;
        Wed, 11 Dec 2019 00:33:32 -0800 (PST)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id bx25sm22710edb.80.2019.12.11.00.33.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 00:33:32 -0800 (PST)
Received: by mail-wr1-f46.google.com with SMTP id t2so23051585wrr.1;
        Wed, 11 Dec 2019 00:33:32 -0800 (PST)
X-Received: by 2002:adf:81e3:: with SMTP id 90mr2310139wra.23.1576053211823;
 Wed, 11 Dec 2019 00:33:31 -0800 (PST)
MIME-Version: 1.0
References: <20191210174710.10649-1-peron.clem@gmail.com> <20191211080633.a6yzwbxi7fcmislp@gilmour.lan>
In-Reply-To: <20191211080633.a6yzwbxi7fcmislp@gilmour.lan>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 11 Dec 2019 16:33:19 +0800
X-Gmail-Original-Message-ID: <CAGb2v66mWgDKyZEWVVYqq5McOaYmiY0PSP7iXE8TBtVZv03u1Q@mail.gmail.com>
Message-ID: <CAGb2v66mWgDKyZEWVVYqq5McOaYmiY0PSP7iXE8TBtVZv03u1Q@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: pwm: allwinner: Fix missing header in H6 example
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Dec 11, 2019 at 4:06 PM Maxime Ripard <maxime@cerno.tech> wrote:
>
> On Tue, Dec 10, 2019 at 06:47:10PM +0100, Clément Péron wrote:
> > Latest linux-next doesn't build due to the following error:
> >
> > Error: Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.example.dts:35.37-38
> > syntax error
> > FATAL ERROR: Unable to parse input tree
> > make[1]: *** [Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.example.dt.yaml]
> > Error 1
> >
> > This is due to missing header in the device-tree yaml example.
> >
> > Fix this by adding the missing headers.
> >
> > Fixes: 4ee929b3f08e ("dt-bindings: pwm: allwinner: Add H6 PWM description")
> > Reported-by: Rob Herring <robh+dt@kernel.org>
> > Signed-off-by: Clément Péron <peron.clem@gmail.com>
>
> Applied, thanks!
> Maxime

Maybe squash it instead? :)

ChenYu
