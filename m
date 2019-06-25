Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F36652835
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Jun 2019 11:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731558AbfFYJio (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 25 Jun 2019 05:38:44 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37640 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729258AbfFYJio (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 25 Jun 2019 05:38:44 -0400
Received: by mail-wr1-f65.google.com with SMTP id v14so17063335wrr.4;
        Tue, 25 Jun 2019 02:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qf/dovgdWTDk466aS2w6QCAW9lwJESqELVwht+4vdoM=;
        b=UK5LsYSqWuafK78PCet8ADx8Ui+gLTbo/kd5PMPzHrB0UVrg8tMhSZfY9qYB7CY0d5
         EuFsae5j40PmZqoQO0A91isoNZS2ySAlziToPDacxit7lura60G9CaPHYdWL1kKjXyD6
         27u59DGDsxiFCrLeYB1H0t1uN2bZ5gP3CIFTtbvOtM3OAGcxqkbvcaDj5ZUK2kgLZbq0
         xy0czAd+/PjiKY8rqVSS2HnYQMz4z6GcLeHH7p/ppyuIBgKX4IItydkKGnyZmKaPn/6K
         zOBZBQhD7/HPxJxWFEPVTC2YZ1caA7ynvRoLYmsGlWuxPgeYcv58svHZ1ZHo6QvR+s7O
         7HpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qf/dovgdWTDk466aS2w6QCAW9lwJESqELVwht+4vdoM=;
        b=IXJZXeI3qohwpbNVYmKdmNLLW2V1JOezkDK/Ta+BRowHhNOWn/YA2LP91oh7Tb6PR3
         0MjyCAUzK7TnW1udR7Yf+fftU3QRaOoaBWWF2hUMdBHhuPnViy9rt7S9Olygyh4dtBfZ
         i83x+J5FFXxwYdxJxeVQjwmu23AJDc5V4Tjobnb4aAfyWOoqVU7UeE2htv8idCfcSV6w
         lYZ6h3tL4HgM1I+/x5qh1EJASkxp1DK5AzVc5JQn8yPW549dliPf4J/iTZSN3TkMhWKP
         wX7Fy5poodL/+kSE/IH9QsmSI3s+SybB3Qrpviak6+Rcn88UTRSUYpvXKF3dutdrKYx2
         krMA==
X-Gm-Message-State: APjAAAUQS+HriKYmT4uS+Bz98LlLsrkIhR5jjc7LXOhRx1nbXtT/uccS
        v5AkoH1TfjgQFoyT0ugHNCI=
X-Google-Smtp-Source: APXvYqw1+B5Zke9wCKXvrY6sFnQ6nzawXFqyztWPByGXC8pJ4XNb1PrX21ikjVB/ftfgcKA516vrTQ==
X-Received: by 2002:adf:de90:: with SMTP id w16mr81130541wrl.217.1561455522093;
        Tue, 25 Jun 2019 02:38:42 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id r12sm14936370wrt.95.2019.06.25.02.38.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 02:38:40 -0700 (PDT)
Date:   Tue, 25 Jun 2019 11:38:39 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        od@zcrc.me, linux-pwm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: pwm_bl: Set pin to sleep state when powered
 down
Message-ID: <20190625093839.GB1516@ulmo>
References: <20190522163428.7078-1-paul@crapouillou.net>
 <5b0f8bb3-e7b0-52c1-1f2f-9709992b76fc@linaro.org>
 <20190621135608.GB11839@ulmo>
 <20190624112844.fmwbfpdxjkst3u7r@holly.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0eh6TmSyL6TZE2Uz"
Content-Disposition: inline
In-Reply-To: <20190624112844.fmwbfpdxjkst3u7r@holly.lan>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2019 at 12:28:44PM +0100, Daniel Thompson wrote:
> On Fri, Jun 21, 2019 at 03:56:08PM +0200, Thierry Reding wrote:
> > On Fri, Jun 21, 2019 at 01:41:45PM +0100, Daniel Thompson wrote:
> > > On 22/05/2019 17:34, Paul Cercueil wrote:
> > > > When the driver probes, the PWM pin is automatically configured to =
its
> > > > default state, which should be the "pwm" function.
> > >=20
> > > At which point in the probe... and by who?
> >=20
> > The driver core will select the "default" state of a device right before
> > calling the driver's probe, see:
> >=20
> > 	drivers/base/pinctrl.c: pinctrl_bind_pins()
> >=20
> > which is called from:
> >=20
> > 	drivers/base/dd.c: really_probe()
> >=20
>=20
> Thanks. I assumed it would be something like that... although given
> pwm-backlight is essentially a wrapper driver round a PWM I wondered why
> the pinctrl was on the backlight node (rather than the PWM node).

I agree with this. We're defining the pin control state for the PWM pin,
so in my opinion it should be the PWM driver that controls it.

One reason why I think this is important is if we ever end up with a
device that requires pins from two different controllers to be
configured at runtime, then how would we model that? Since pin control
states cannot be aggregated, so you'd have to have multiple "default"
states, each for the pins that they control.

On the other hand if we associate the pin control states with each of
the resources that need those states, then when those resources are
controlled, they will automatically know how to deal with the states.
The top-level device (i.e. backlight) doesn't need to concern itself
with those details.

> Looking at the DTs in the upstream kernel it looks like ~20% of the
> backlight drivers have pinctrl on the backlight node. Others presumable
> have none or have it on the PWM node (and it looks like support for
> sleeping the pins is *very* rare amoung the PWM drivers).

I suspect that that's mostly a sign of our device trees and kernel
subsystems still maturing. For example, I think it's fairly rare for a
device to seamlessly take over the display configuration from the
bootloader. Most of the time you'll just see things go black (that's
actually one of the better cases) when the kernel takes over and then
the backlight will come up again at some point.

Taking over the bootloader's display configuration is pretty hard and
there are numerous pieces to the puzzle (need to make sure clocks and
power supplies are not automatically disabled after the initcalls,
display drivers need to know how to read out hardware, claim whatever
memory region the bootloader was using for a bootsplash, backlight is
supposed to remain enabled if the bootloader turned it on, ...).

I don't think the fact that PWM drivers don't support this implies that
hardware doesn't support it. I think we've just never needed it before
because we get away with it.

Thierry

--0eh6TmSyL6TZE2Uz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl0R650ACgkQ3SOs138+
s6FApw//X6YPIMSBehRgeG/YYLTIA2NFvbDmGSL7AndIcj/QTu4qHzVehMDRtQOn
wgw+SF/yRrqGryLdFI7EdfslMS++FvPSwtowwRt1BWGog372Q63Zgl0o147klX2/
iXcoF7eBV9x9Ied+XVqjLs3Ag0BQAX9AV0MRnXmBz3IOicg3bU8n03xcyZCDAWvc
w95lmRGM9z+iP2I3W73i+4+3hj6jgUztZsopwa0t56Bp8q0dcqX9Bm6ap+pcxAmX
MPFcogA6k8Qj075yujpCCzY6Y3z4ZV2MRyIhA0f3PZnFl37+liS3gnDqdq5PXNXN
+DVhI5rgB7ZOi1MSkPRgHbtn2XkOZ+ct1QW1dvd/Na4CuVny67/CfvshUOd7y+y9
I9QPlEvlNGvBHtEbFGEAjF4VOH3j7moN48CK41hxkLBlcuQJ6s5MBGxNQaRK0UC2
+QLrVgsQriv+NnzaLKEiGlBIJMRZjaRYYTpywXDI9nuiEEBPNppXbzyAamIZbcup
nJapCAsSaO1h4WnmP0Alo0hjyW6kQx9aCoWWAySeUfVkeGPK6Ogqgteda+ob5qjc
h20T6YzAa0Mky7j52RUPdHCxu7q6dRrNS5viGqyBSzyvkSZgYN3Fkys3x4dnLl/x
McVvQdPQ51Os3ftQ3u03yRFdPJ34ZVV/kFy7Y7G0XSM9gEroD1I=
=pSQv
-----END PGP SIGNATURE-----

--0eh6TmSyL6TZE2Uz--
