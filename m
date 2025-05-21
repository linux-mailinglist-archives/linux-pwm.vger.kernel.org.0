Return-Path: <linux-pwm+bounces-6038-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBBAABF0DC
	for <lists+linux-pwm@lfdr.de>; Wed, 21 May 2025 12:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EC441BC10CC
	for <lists+linux-pwm@lfdr.de>; Wed, 21 May 2025 10:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB0E25B680;
	Wed, 21 May 2025 10:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJvVViyn"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B202B22B59D;
	Wed, 21 May 2025 10:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747821962; cv=none; b=qF6qi8pGZaQZ0tapH4BhMNOVcUfMdSWpAOl7mQTbLaJFyF7fxbqJ5w57Q7QVfaqoy7JuHp4QcYvabt/8zkcULwskmDm1EcJSeESouKIYUhCYI803DMKpfW7r+yCNLYdFqscR5DlpqCPkolLNA8INgnTGOVye8TNfVs8o8kykCXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747821962; c=relaxed/simple;
	bh=rgpHS6odt8O+9cVHLbseHNc02b3rzGap9plTyMx3efM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XteMS7gVm405fmfOb3jTmf2dzBJ3646htsR2Zw13IGIgcs81UFU6Vz3VABoUzgxJSVIF1Em8lHlPAesZbo+poAYsdl/sb9c0SQePpNJ+EJC+Ir5D8VoaDS2/F8LwieMzzG/w6uFZTZXthrjEJiJA/fr1UOXd++D5QZRcPE2DQBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJvVViyn; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a376ba6f08so1642784f8f.1;
        Wed, 21 May 2025 03:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747821959; x=1748426759; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TTIuF48hT1VIO+kFRM3ZksKoxyuQX1QYGQQ1D+1eNgo=;
        b=RJvVViynb5vw8oj25KbGKWqR4VicHpQdp1e8HDJkOF6d0DNtB/exqD9t/I9FTdlpS6
         fcvCIKYBTlOpGBQWpVlnncMk/YquGJsfIhHXw19GuSHApqeVjrF/uIKqdmgT2OWt+LL2
         K2eZrAQqq2U1+3c8oMMUe7fGFzz6xkLv1ps+3eXDG8ZaxHyy53Dr0wqzSuMZoyOb4DR5
         kc1sp4EXaLsbFP5COkoEmuEfXvKCfrDvwhqr4f8ofhQFxD8SHWuoHdGN6YeJiyC5gtY5
         iPJ7y43CZBhSAQh1gNWjyMGKeT+et/76nx86ABVfJCCBCiVIDqIFMnj6Ue4uoHV9Rn73
         tg9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747821959; x=1748426759;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TTIuF48hT1VIO+kFRM3ZksKoxyuQX1QYGQQ1D+1eNgo=;
        b=iieLHu8uTEZ9mbawg4+t4KKMYZW+H0kMvuK0lHrCEyv1XKGUUHOl/uyq0q6pty8MRt
         clfY0AIwSWynFBigAXAJrvSZo80xwcQVO2oatGc+YfCm+rCdN1YGJx6lE8+6ZOfVfLU0
         H0f/J8ngdE+OqboqYmxPH1K4QXtvNEai/QpYe0X47tAOYZ8vKcm2pExUycfRQd/cz/PD
         hj7NSaXMwZdneLVTbXgmrMPCDMoM2utHIl+3R0fgPYRK/sc0mYQkpiAuFaGJz0LHhPVO
         Uo7bFEsEFXzr+uVVLWQGWxs4CBk+aNtIqDLI8jMQbKVB1rBpRWGQhpt/d3mhsQ4UiXrO
         N3aw==
X-Forwarded-Encrypted: i=1; AJvYcCUm4Y+OAvLacYtQwVgRku+LGuv0usGz8+3P/kbSD/rgDiFVPqjkn0WChjAfeUMfgiiVeQ8dCPWodk52@vger.kernel.org, AJvYcCVWUtkLLaFFwo1tMwZXp77girs7ddJfSiuKx8/du1F+vOmh0pHKMYFitSod76PHDGtMuK7A2q7xNhKIBw==@vger.kernel.org, AJvYcCX0PAtLkEPa9SqoXnkn28lChTuXtFbbfD9+TD+vKSbapMtaybw1nWWn5uJtdDsG7vynZPhP95A0/HsrOV0=@vger.kernel.org, AJvYcCXuj3wCA4HGzyilYRrSyWdA9RvnjHChcDD3yrtpWf2YPezkIkjr1qIRsmtEZPk6LTIPjOa+98GVNupq@vger.kernel.org
X-Gm-Message-State: AOJu0YwdwYveNtWf/Kk7ZIVOk0b2SNKlOaVtitDRqLQvn3BCDa9xRw/O
	5JNcb7AtkPubJhnDEihL4qy7A76aPj3ylVurwujX4phgUQoPyflBnL+QYYwFhTJR
X-Gm-Gg: ASbGncvlHJzp/rcYQmJ1o1l7w3LC7EB30lU883pzVskU0IxuoOaq9pZEVPZYp7M7AHy
	oKFa+FaaEiwwYAi52bvFjQCz8ALexb+bqe4mIotbI923Yf0R1BB01deRimFl2WqhIRnCEg1y4M5
	Y0mlrkgDaTf9r+xtfkLDQ6E0Tn7HQ7g/4Anhtd7SLsg0sZNqVSx7R+7kc7jRUKoHRP97kqFPoar
	J5NI5N4RVaiJ/0PRCR7ENOskLapSnS4l+r77BtxjJ58vcdiVBcq+0KfjdofFYJXF2jxxY9776N8
	OVlZfv3GyCOXLS0C6GehQV5Hn1NdsbDHrRjZ59Ogfo7S4Cgtw1jl5av/9k2Rvg==
X-Google-Smtp-Source: AGHT+IGqJqjO1k+2GagPj1k1t5vNX5vNx9TGKCAwGHi6OPzScOjdKZTJ+ivLGE03x/gUNfxSIiq3Vg==
X-Received: by 2002:a5d:64e8:0:b0:3a3:76f5:3b0d with SMTP id ffacd0b85a97d-3a376f53b87mr7693575f8f.57.1747821958734;
        Wed, 21 May 2025 03:05:58 -0700 (PDT)
Received: from [10.5.0.2] ([185.174.156.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a36a83b63bsm13356757f8f.97.2025.05.21.03.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 03:05:58 -0700 (PDT)
Message-ID: <497d549b6d055cf6402a9777c1295f5415174c86.camel@gmail.com>
Subject: Re: [PATCH v3 17/22] Input: adp5585: Add Analog Devices ADP5585/89
 support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: nuno.sa@analog.com, linux-gpio@vger.kernel.org,
 linux-pwm@vger.kernel.org, 	devicetree@vger.kernel.org,
 linux-input@vger.kernel.org, Lee Jones <lee@kernel.org>,  Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,  Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=	
 <ukleinek@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Bartosz
 Golaszewski <brgl@bgdev.pl>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, Liu Ying	 <victor.liu@nxp.com>
Date: Wed, 21 May 2025 11:06:00 +0100
In-Reply-To: <j2zueeyfq2mkr56b5pauektzqwfmo4ob32fcb7r5oavwdunsab@6knd5a6raaef>
References: <20250512-dev-adp5589-fw-v3-0-092b14b79a88@analog.com>
	 <20250512-dev-adp5589-fw-v3-17-092b14b79a88@analog.com>
	 <gdhn57zkmt5fyq33qsvdbpq3k7ofzycm24ligd3hw2cwdqkn5y@z4sk2arp6ssn>
	 <0b17ac3e9de55715fe1cd5f836a87664ae6161dd.camel@gmail.com>
	 <j2zueeyfq2mkr56b5pauektzqwfmo4ob32fcb7r5oavwdunsab@6knd5a6raaef>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-05-20 at 11:33 -0700, Dmitry Torokhov wrote:
> On Tue, May 20, 2025 at 09:32:53AM +0100, Nuno S=C3=A1 wrote:
> > On Mon, 2025-05-19 at 15:29 -0700, Dmitry Torokhov wrote:
> > > Hi Nuno,
> > >=20
> > > On Mon, May 12, 2025 at 01:39:09PM +0100, Nuno S=C3=A1 via B4 Relay w=
rote:
> > > > +
> > > > +	for (pin =3D 0; pin < n_pins; pin++) {
> > > > +		if (keypad_pins[pin] >=3D adp5585->info->n_pins) {
> > > > +			error =3D dev_err_probe(dev, -EINVAL,
> > > > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid keypad pin(%u)
> > > > defined\n",
> > > > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 keypad_pins[pin]);
> > > > +			goto out_free_map;
> > > > +		}
> > > > +
> > > > +		if (test_and_set_bit(keypad_pins[pin], adp5585-
> > > > >pin_usage))
> > > > {
> > > > +			error =3D dev_err_probe(dev, -EBUSY,
> > > > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Keypad pin(%u) already
> > > > used\n",
> > > > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 keypad_pins[pin]);
> > > > +			goto out_free_map;
> > >=20
> > > This jump looked confusing, together with devm, etc. I wonder, can yo=
u
> > > move call to devm_add_action_or_reset() before the loop? It looks lik=
e
> > > it should handle completely unpopulated pin map just fine...=20
> >=20
> > Seemed the logical way but I agree that what you suggest makes it more
> > simpler.
> >=20
> > >=20
> > > > +		}
> > > > +
> > > > +		__set_bit(keypad_pins[pin], &kpad->keypad);
> > > > +	}
> > > > +
> > > > +	error =3D devm_add_action_or_reset(dev, adp5585_keys_pins_free,
> > > > kpad);
> > > > +	if (error)
> > > > +		return error;
> > > > +
> > > > +	/*
> > > > +	 * Note that given that we get a mask (and the HW allows it),
> > > > we
> > > > +	 * can have holes in our keypad (eg: row0, row1 and row7
> > > > enabled).
> > > > +	 * However, for the matrix parsing functions we need to pass
> > > > the
> > > > +	 * number of rows/cols as the maximum row/col used plus 1. This
> > > > +	 * pretty much means we will also have holes in our SW keypad.
> > > > +	 */
> > > > +
> > > > +	rows =3D find_last_bit(&kpad->keypad, kpad->info->max_rows) + 1;
> > > > +	if (rows =3D=3D kpad->info->max_rows + 1)
> > > > +		return dev_err_probe(dev, -EINVAL,
> > > > +				=C2=A0=C2=A0=C2=A0=C2=A0 "Now rows defined in the
> > > > keypad!\n");
> > > > +
> > > > +	cols =3D find_last_bit(&kpad->keypad, kpad->info->max_cols +
> > > > kpad-
> > > > > info->max_rows);
> > > > +	if (cols < kpad->info->max_rows)
> > > > +		return dev_err_probe(dev, -EINVAL,
> > > > +				=C2=A0=C2=A0=C2=A0=C2=A0 "No columns defined in the
> > > > keypad!\n");
> > > > +
> > > > +	cols =3D cols + 1 - kpad->info->max_rows;
> > > > +
> > > > +	error =3D matrix_keypad_build_keymap(NULL, NULL, rows, cols,
> > > > +					=C2=A0=C2=A0 kpad->keycode, kpad->input);
> > > > +	if (error)
> > > > +		return error;
> > > > +
> > > > +	kpad->row_shift =3D get_count_order(cols);
> > > > +
> > > > +	if (device_property_read_bool(kpad->dev, "autorepeat"))
> > > > +		__set_bit(EV_REP, kpad->input->evbit);
> > > > +
> > > > +	return adp5585_keys_check_special_events(adp5585, kpad);
> > >=20
> > > 	error =3D adp5585_keys_check_special_events(...);
> > > 	if (error)
> > > 		return error;
> >=20
> > Curious, any special reason for the above? Or is just personal preferen=
ce?
>=20
> More of a personal preference, however there is some logic to it ;) -=20
> in a function with multiple failure/return points such form allows for
> easy addition and/or movement of the code.
>=20
> Thanks.

I get your point. Honestly still prefer returning right away but no strong
feelings anyways. I'll change it.

- Nuno S=C3=A1

