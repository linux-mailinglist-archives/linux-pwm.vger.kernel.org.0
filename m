Return-Path: <linux-pwm+bounces-6030-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B03ABD204
	for <lists+linux-pwm@lfdr.de>; Tue, 20 May 2025 10:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BF051BA013B
	for <lists+linux-pwm@lfdr.de>; Tue, 20 May 2025 08:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DCF264A9F;
	Tue, 20 May 2025 08:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4CfLSo3"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006F725EF82;
	Tue, 20 May 2025 08:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747729975; cv=none; b=ffnX+L60L1uCOWxRHjb2DJYrhEu+tKrpE1pdrrklflLN1Fq8SFCRBX2g3zFhNusqKoxX1kBlEGWe+QmHVA6LPcOJ+Oz5qwdvota6SRPRb7Ji+cTuoNuQH6OT5aVuUqD9ty2K/DKjOusa3jCfYSZbZumDR7LBeHYfSaDWmvGszTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747729975; c=relaxed/simple;
	bh=Xyna//iV30zdmxu+lhFtO3p4ki+B6MtfiK4oqZ8qmwU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kSdFvvuOtHxOt7eY0jh7oYgZ7X9fqBk1ngpvtPE75Yu4qmFWCdwJ590WJMeMnYPO0oi+T/BKJCNtM8F0mF/DWcg2RHe2kv7EhXzTWidceWwgAoreL0w6JTYJnMVUkP6G5IvqYME9pwjn1aKK+/ipGITHK90TjNqxMDeGpMXoI9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R4CfLSo3; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43cf257158fso38949935e9.2;
        Tue, 20 May 2025 01:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747729972; x=1748334772; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4gAALloRFs6xpcLbhCpkh9PQ/E5ARgCl3rcLighGQiM=;
        b=R4CfLSo32L8m48hQtki9fmMQp3yhvuqOKYt4mdgjR4Tt0zK6/+9Tx7VKSvAdIIJxoo
         SC4qXN1AySR8Kr06MyHk2HEgBqkcrZT7Nq/frhZwRGHi1Ucd429xarfn21lKXEBbAddm
         TGQ1fb9MUeRFSzLw0qHxNCnuXuv5iKSTwye7/dgR8Gq/GfELt1/01Eku8FeEid0tlU/0
         SS6rGErpo/+Ck0K+bnI4Ific5MVIjEcn0ZhTkvmDykudsHZ9qNhYcIeJsRUp0cEyB9+u
         9PgPyUKHA+f0SrvKSUlLXPfO4JWs8ROqyhAG06t/axbaB1Gzvx1nJsUeA1WbAG3E8A3F
         +U6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747729972; x=1748334772;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4gAALloRFs6xpcLbhCpkh9PQ/E5ARgCl3rcLighGQiM=;
        b=XgnXvh/Q7SR/HH9nQb4osObR2Lc1H4w83q/fod4gWOI/fq6s60Sji5DHb8v/LaNGqQ
         aiHIH+GohfgdUbahUKbpMrKhf7/sXdgQzZ/EElH3udJUr+kGya9Xx1HLsc3jMSKyhE7l
         rGg+imBPgK4Bm1x1yAndwsZt2jqIKeetvtP7b/LQzvqF6/u8SxYK4n4qEoqXTTsMiKS6
         EIdpjxMwUinbFC3QV5WTy3lEplMNUYor1AzXkmpDTTdFGeE/T3k15Z4t2HxbV/UJ2M4J
         em2Js5etmN5oeDcpSRB4Q+3gVNPy7jiRGE+5tUYCa6ka9RsGfY9WAymevdiY9tHFZMce
         ZPWA==
X-Forwarded-Encrypted: i=1; AJvYcCWILNCq3QNGgG40BKsRwxaSLv5/m7zzPiziwBYOkoYoi+rhoUKwMWh1LGdH4z9VO824Xju23osqYGII@vger.kernel.org, AJvYcCXPkyeE2ufeelE3+zgwr9mafcTStROOtKlSTIZsa/YCKsLcmZA6RLY6WKrJvotfo7LiQO1Qw8FrQOrBGCk=@vger.kernel.org, AJvYcCXSa+uKbgpxQ9jzni5n6ilbTyiEjD3ScTzp0hrf5ayCp1yP6Hmx3XyX4jeuLi6gSdi4ZKH51k6H7KYE@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu0DrZ5G8SP8i4e6L8BCxSObewPQBhuzK4LqvIYnQTEutA42+Q
	KPp3emEkiWO/p5OOUsl8MrCV2NCPiMJcJIhwucTVHadJcS7Y0SUzxapGNcxTfmXTBUs=
X-Gm-Gg: ASbGncvGKO+nY5nALEPHxc4W+hLGhZgfw80TONNVcI68BlAOdSPdWN8cNOClVwHjglX
	Tz8GuWtVfAi8V1JrVGvzgyE/WyQ2Tbc7g8kLg8axOkWSqhxXDeVogS4A7U6pxCuw2xvYCg+d5wD
	5/cHeCTDzDMZ/CDX+yRhM/ygzpToHSIVIgwN3KzO8p9nl5n+988Fw5yEzcKj/t5BgVmvwlWIR3g
	SbBEikJ32d9CHc7W4WKuMQTG/3kUhEXSeQpqrNAEqfkH0B+bTptfxrcsWtMrDgH5m6OCB+x1r5X
	pmnRcX16LuHR6AY04EcJ0IcVl1hnWkZyoyGTiy90pXYuE9r2B28=
X-Google-Smtp-Source: AGHT+IEzV7bJ156Gtlkq0aP6LG13IpnmRvOXZxuDnpHbYmlgZbAfIHmvVQIhdm8JKygCB4pnJmlkJQ==
X-Received: by 2002:a05:600c:154b:b0:43d:fa58:8378 with SMTP id 5b1f17b1804b1-442ff03c7ebmr111322095e9.33.1747729971916;
        Tue, 20 May 2025 01:32:51 -0700 (PDT)
Received: from [10.5.0.2] ([45.94.208.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f7ca2de7sm21172605e9.35.2025.05.20.01.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 01:32:51 -0700 (PDT)
Message-ID: <0b17ac3e9de55715fe1cd5f836a87664ae6161dd.camel@gmail.com>
Subject: Re: [PATCH v3 17/22] Input: adp5585: Add Analog Devices ADP5585/89
 support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, nuno.sa@analog.com
Cc: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-input@vger.kernel.org, Lee Jones
 <lee@kernel.org>,  Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,  Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?=	 <ukleinek@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Laurent
 Pinchart <laurent.pinchart@ideasonboard.com>, Liu Ying	 <victor.liu@nxp.com>
Date: Tue, 20 May 2025 09:32:53 +0100
In-Reply-To: <gdhn57zkmt5fyq33qsvdbpq3k7ofzycm24ligd3hw2cwdqkn5y@z4sk2arp6ssn>
References: <20250512-dev-adp5589-fw-v3-0-092b14b79a88@analog.com>
	 <20250512-dev-adp5589-fw-v3-17-092b14b79a88@analog.com>
	 <gdhn57zkmt5fyq33qsvdbpq3k7ofzycm24ligd3hw2cwdqkn5y@z4sk2arp6ssn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-05-19 at 15:29 -0700, Dmitry Torokhov wrote:
> Hi Nuno,
>=20
> On Mon, May 12, 2025 at 01:39:09PM +0100, Nuno S=C3=A1 via B4 Relay wrote=
:
> > +
> > +	for (pin =3D 0; pin < n_pins; pin++) {
> > +		if (keypad_pins[pin] >=3D adp5585->info->n_pins) {
> > +			error =3D dev_err_probe(dev, -EINVAL,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid keypad pin(%u)
> > defined\n",
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 keypad_pins[pin]);
> > +			goto out_free_map;
> > +		}
> > +
> > +		if (test_and_set_bit(keypad_pins[pin], adp5585->pin_usage))
> > {
> > +			error =3D dev_err_probe(dev, -EBUSY,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Keypad pin(%u) already
> > used\n",
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 keypad_pins[pin]);
> > +			goto out_free_map;
>=20
> This jump looked confusing, together with devm, etc. I wonder, can you
> move call to devm_add_action_or_reset() before the loop? It looks like
> it should handle completely unpopulated pin map just fine...=20

Seemed the logical way but I agree that what you suggest makes it more simp=
ler.

>=20
> > +		}
> > +
> > +		__set_bit(keypad_pins[pin], &kpad->keypad);
> > +	}
> > +
> > +	error =3D devm_add_action_or_reset(dev, adp5585_keys_pins_free,
> > kpad);
> > +	if (error)
> > +		return error;
> > +
> > +	/*
> > +	 * Note that given that we get a mask (and the HW allows it), we
> > +	 * can have holes in our keypad (eg: row0, row1 and row7 enabled).
> > +	 * However, for the matrix parsing functions we need to pass the
> > +	 * number of rows/cols as the maximum row/col used plus 1. This
> > +	 * pretty much means we will also have holes in our SW keypad.
> > +	 */
> > +
> > +	rows =3D find_last_bit(&kpad->keypad, kpad->info->max_rows) + 1;
> > +	if (rows =3D=3D kpad->info->max_rows + 1)
> > +		return dev_err_probe(dev, -EINVAL,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0 "Now rows defined in the keypad!\n");
> > +
> > +	cols =3D find_last_bit(&kpad->keypad, kpad->info->max_cols + kpad-
> > >info->max_rows);
> > +	if (cols < kpad->info->max_rows)
> > +		return dev_err_probe(dev, -EINVAL,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0 "No columns defined in the
> > keypad!\n");
> > +
> > +	cols =3D cols + 1 - kpad->info->max_rows;
> > +
> > +	error =3D matrix_keypad_build_keymap(NULL, NULL, rows, cols,
> > +					=C2=A0=C2=A0 kpad->keycode, kpad->input);
> > +	if (error)
> > +		return error;
> > +
> > +	kpad->row_shift =3D get_count_order(cols);
> > +
> > +	if (device_property_read_bool(kpad->dev, "autorepeat"))
> > +		__set_bit(EV_REP, kpad->input->evbit);
> > +
> > +	return adp5585_keys_check_special_events(adp5585, kpad);
>=20
> 	error =3D adp5585_keys_check_special_events(...);
> 	if (error)
> 		return error;

Curious, any special reason for the above? Or is just personal preference?


- Nuno S=C3=A1

