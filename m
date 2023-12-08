Return-Path: <linux-pwm+bounces-465-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C4180A8A9
	for <lists+linux-pwm@lfdr.de>; Fri,  8 Dec 2023 17:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D9E81C208D8
	for <lists+linux-pwm@lfdr.de>; Fri,  8 Dec 2023 16:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C624374D6;
	Fri,  8 Dec 2023 16:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1Maeo2o"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A3D1987;
	Fri,  8 Dec 2023 08:22:56 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-54f5469c211so937359a12.0;
        Fri, 08 Dec 2023 08:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702052575; x=1702657375; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=svN1Ndc4QwmNHTO/oqyCiy4PAweEtdwQk3CfZUa3eYo=;
        b=W1Maeo2o795gYWbrsrMSx81cARvMmDKOgt+wEwXRdvGki2A8GY3wwpZzsGElpUqWuc
         h8JtN2scX+o+7KFwRX4fT1foDFKOjuG7K/NW+ftLdY4HU+L6MKEW9lnos8mVMrsi5lyW
         8tlnFMx9bJC44IWyAkhFYksPc3E0NLG3ixzoZyGV5GhzOaGhIk0UPFTDHgFAX0vtbWyC
         yDrb/UwC1m2ZJvQnFjX4RkBapnRm/2USvWWdEA4PwoJTh99T7K/ukKLp4USGAG9N6sN/
         M5acjtALmEf/hLDg7GuqZB8EdANxitVN/v3BigEoL0IcofwIJl0F3YkBurwE3L0x5BwY
         yYSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702052575; x=1702657375;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=svN1Ndc4QwmNHTO/oqyCiy4PAweEtdwQk3CfZUa3eYo=;
        b=LRaKfM0kiomLP2kpLspgFpGXj9BtmVjsrnowF9FFT6cM+Do67sG0fLo1SBDBwUmyg5
         Ecq10PFJQAzrlFDNloMp0h5icJM1eGYQsu7wJUNrjOBzP/HgN/amHhSjVb9Mi3zSN1Dy
         OlJSaVv5BZrOOiaNSGdwaL1YC2UpMbe7lj8uSNloEPu7mR8qi3xA0624lbvUiaoJW69g
         1FWr0uNf1eaobaHhAvROV7S7v8t9yrw8uYcSa3zhkqK3st8NBbzAGAKbuNtQezMZluci
         e8fNJVhuJrqBuO0M1nKCCl2RIN6G9FWm4rhNKZFf+rE4D9djvU6A5fFLILXT+WY6Kd4H
         G66w==
X-Gm-Message-State: AOJu0Yz8awtT4JGVG5xXLzPAJHEK8XR1Ry6PPL+M8SRFQvIDghAO2jVM
	PZVCYpHho19GIJDlRlfy9Fg=
X-Google-Smtp-Source: AGHT+IEqwxQJzb5eeyuxkgyTXIammuAXFxjBenJ1bmCkFNPrxhJJolH7wvgdlhFIJgOFnUSf+Q7z2g==
X-Received: by 2002:a17:906:7951:b0:a19:a19b:c708 with SMTP id l17-20020a170906795100b00a19a19bc708mr149642ejo.88.1702052574810;
        Fri, 08 Dec 2023 08:22:54 -0800 (PST)
Received: from orome.fritz.box (p200300e41f0fa600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f0f:a600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id vi8-20020a170907d40800b00a1c7b20e9e6sm1179290ejc.32.2023.12.08.08.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 08:22:54 -0800 (PST)
Date: Fri, 8 Dec 2023 17:22:52 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Sean Young <sean@mess.org>
Cc: linux-media@vger.kernel.org, linux-pwm@vger.kernel.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/4] pwm: bcm2835: allow pwm driver to be used in
 atomic context
Message-ID: <ZXNC3JYy7CTfYsyC@orome.fritz.box>
References: <cover.1701248996.git.sean@mess.org>
 <179dc1ce85702a8b64b43c0e0df656b0c5e3ce30.1701248996.git.sean@mess.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ix9F9B72gOKa/1mD"
Content-Disposition: inline
In-Reply-To: <179dc1ce85702a8b64b43c0e0df656b0c5e3ce30.1701248996.git.sean@mess.org>
User-Agent: Mutt/2.2.12 (2023-09-09)


--ix9F9B72gOKa/1mD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 09:13:36AM +0000, Sean Young wrote:
> clk_get_rate() may do a mutex lock. Fetch the clock rate once, and prevent
> rate changes using clk_rate_exclusive_get().
>=20
> Signed-off-by: Sean Young <sean@mess.org>
> ---
>  drivers/pwm/pwm-bcm2835.c | 31 +++++++++++++++++++++----------
>  1 file changed, 21 insertions(+), 10 deletions(-)

s/pwm/PWM/ in the subject. Although, I guess you could just drop the
"PWM" altogether because the subject prefix implies that this is for
PWM. Also, please capitalize after the subject prefix.

Thierry

--ix9F9B72gOKa/1mD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmVzQtwACgkQ3SOs138+
s6Gu+A//W4O0yDv+AftK43w4DyKG2lCSU+7O2mfysoZU6ycgaOLqxvfT6HYr4W/X
Uleddmj5ZkyERd4gtLMC9Z5tIJbpjNEoMusUd96915jXWs4SRu8U2w4s+MMuysbN
h8xJmZleGPOtJl/dI60jDJ+zogYUhmxuTQxvDbEmFPevHRChzEefwKz0DzvUKUz4
3r7suWMDBq2Gb2wbST/Iz5JfPhZtxiKd0nkxc04JKXMdfH9UhdFW33ZaYTwUqlvA
gT1SGIOBZ133KObMEQzptxVw47v2wxRRCJdTUfIjv7gKa+8xJhQkthL2hhdEHkoK
3fN7FEUtYJE9L6GO9bXfTUwjk1PMHABmzxKjuxhkTKzjZsobN4SmLOa+dvh5F51J
U1mtGYYjcZlVrIEIsi252XvRpcP8trGRI/1pb9NXuvgJTpbCfsC2FPpf+d/OCs/J
hLsinFaorOrQcf9rTJfkwmMh+obDKlVik81riYAZC0wL9KWgAdhG1f3ZqlwHU+rE
gEUtKWUad+QO6dg5wFk+olCDvR4SwRsirkjpR2JJW5XmEC01BGqw/f7SXIdeU6B9
VKV9pc96952S7Ygrj5Ht3gWus5UwC+S6KFbcIJxWfbYby1lxMddZkoTWbMj2Lsth
mqdNbKHB/kNADvHfcemFkxb+kWfu0bkMuhTRFT5dgLsc+hIyins=
=BCvn
-----END PGP SIGNATURE-----

--ix9F9B72gOKa/1mD--

