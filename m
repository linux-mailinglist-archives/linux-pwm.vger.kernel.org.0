Return-Path: <linux-pwm+bounces-6074-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E08ABF9FF
	for <lists+linux-pwm@lfdr.de>; Wed, 21 May 2025 17:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBE8A504584
	for <lists+linux-pwm@lfdr.de>; Wed, 21 May 2025 15:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D06225A3D;
	Wed, 21 May 2025 15:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOzf5PFh"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA3C2D600;
	Wed, 21 May 2025 15:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747842037; cv=none; b=B8n/JFYp/jSFAqCBh+hd22HMA3Dnhmm8wJhguH7LfLrkeBACrn+x0NCBnlCqn0z3MsofuBmxjGeAc6lPpeNRBx/LNGQEyM6SenaCBSY7uKy8NgWTIFsL8mcAl7SSgWlrJYMNIVClf79hlIEIP2gJQUa80CJPTCvrQ7OXGGSA04g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747842037; c=relaxed/simple;
	bh=WWybUzX9+enX5WhBLpymBohtr4pJahuvChepfYjdv8c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DrWNzPI3lns3aMC5Gi3wek45B9AlrLptJIv8YBZuBAjbO0RrB2PVFTYQaln0zJHJyxWl0t3sFrKnmDC5zvXn1bWDW6L0T3MW6qYT43lWJDhAZQj0wXMDaff3OLe2Bmit5ywfZtUgzKCUdBu2B9O736af/0374fLvvRJqRAf1jDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DOzf5PFh; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43edecbfb94so75487445e9.1;
        Wed, 21 May 2025 08:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747842034; x=1748446834; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HU9cy2gUy6ufy9S1ZzxEh7gznOLoOchObUxt5fz4WP8=;
        b=DOzf5PFhTy0b5keK1hggmtKS17GHlbeCMvi9PUVrerJytBjMv1lcTW1W9gKNHw0JmJ
         ENrxK/G8vuyGDTkTbDhfX0nZ7OBGSN5k7nURJTOKIXTyPAxaAsxpMcdoTTAek46IkuQC
         XVAnh7r3oN2CqjJWL9WRxuql8vTCRUKx/u2lWblOV3+/1uU+65le3XjUCs+hjaAR0qdd
         nJPp0HOB9+FAA7HrOrkD+WFlDCgErVblFKPeqvWKzUaFgaaWTUE4IWJR1ti3hvEoYihq
         BiaYUIhBZU/v5JudCGS1NYFoblfXLafrOISAJHTNTguiRxr/FSjmTr+WfT0UPhy4JvEn
         YUVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747842034; x=1748446834;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HU9cy2gUy6ufy9S1ZzxEh7gznOLoOchObUxt5fz4WP8=;
        b=t1XTxrA6NQ6Zdn5boXeiHbLJ1PMl3WjaXOTZsleFXxMYCdpP413pSy6WekCqkqWLRP
         HZGKzcVvdofWfMtgi7+MVr8AIPIHmgxA1P19AVcqNmg9Kt7erL6CyhBpIWIoHSRKk0EV
         CRz2lN20KOdrFiUO2n/or+g/4rWtIxbvADOTxwjfnQ7EHyJ7rAowYsZ5OORWh70Vz7OD
         M9PwCXedZQB56e6tajnpyCax1Q0uQGvG6JH5277Bgg4NYmTaLN4W9zrVleZZT5h3mpj3
         9q2RvxisKCy6Ox6bEU2YIHZb4jIPLk4AMyPNELrC+7dMyIJ8nFDv0JGJ5p9lzyyYLFOb
         kD9A==
X-Forwarded-Encrypted: i=1; AJvYcCUZIs2GIH3WSMc+K9F5aOpx8P2cQLB/6msDJRlaogzef5jhcOLCtBL506XOAkX9IGzBZo7hQ8a2hy0SjJ2d@vger.kernel.org, AJvYcCWTdncl+FOM52IiwzsqYWXUiW/0M2jiX7slWq0pk8OsG2rVXPTXTFiiBGRZgJbZ5KfsVX7kC0sUZqtn@vger.kernel.org, AJvYcCWuikoMEqYyI1PYJoLbRiuee9C6biuqWqhzF7EMdZT3f2WcnQQP56psWWW/1tg2xalkNSjuCtGEG5Dk@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5PE409Sl5fC/Vuju+pNfs1AaNWyq5sPlG3k7Uztvu4HJwU3tf
	lMgW0J3joJvpaavICHfXh0ZPbrS0jAlP7hX8s7ZgXWWxzNtlX5qq25vNHYURRM8XMqc=
X-Gm-Gg: ASbGncuqhH/5WeDYZ1wVtvBJHbnRJ1Ms/F2KmkvksGff0dUzFHr3rGDVWn3C8W6DGvZ
	b7zCGBQeu8SANQwDGXzSRfRw/oI0RYALQHu4Wtm8dNGD/0qRjFIYEynfONjiQ3f4XsuG2A4NGw9
	MM0VzVm8fLbFPIPl7D8Rl+bHuqWYtw2ZW4PRhRQDirjJ6bFXFwfh7923k8D0reMtTw496/KgwFw
	A7o1bdgKRN7YQxNyQf/rCbD9Seojs9+hr0YJihh3Z1t/nshxJCyrLFQ2eCh8kX4GmV3L0cs3B3P
	uKV+stiPAP9zPuvY0feB2A1k0WPOiZvwlEBQQ5Mk5nh3j52ndAc+gGnGja+j77t6XnOZp4p6QE1
	1ZoxgTY/U4MsIfXk89QlWrhE=
X-Google-Smtp-Source: AGHT+IGfvwOIaCTEr+mXa15ntnTOu5fIv2LfcCEWFjpHplD7RkQ006oThxUBuuPh1cps7O8oc/L4Uw==
X-Received: by 2002:a05:600c:3e0d:b0:442:dc6f:4a07 with SMTP id 5b1f17b1804b1-442fd60873bmr213000825e9.4.1747842034074;
        Wed, 21 May 2025 08:40:34 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca6294bsm20455401f8f.51.2025.05.21.08.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 08:40:33 -0700 (PDT)
Message-ID: <1cc3232e94318f22ff30345326151e8db5381084.camel@gmail.com>
Subject: Re: [PATCH 3/3] pwm: axi-pwmgen: add support for external clock
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?=
	 <ukleinek@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>, Nuno
 =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>, Trevor Gamblin
 <tgamblin@baylibre.com>, Rob Herring	 <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley	 <conor+dt@kernel.org>,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 21 May 2025 16:40:35 +0100
In-Reply-To: <d2803c4a-d4ee-47e6-9bba-2d042051f980@baylibre.com>
References: 
	<20250520-pwm-axi-pwmgen-add-external-clock-v1-0-6cd63cc001c8@baylibre.com>
	 <20250520-pwm-axi-pwmgen-add-external-clock-v1-3-6cd63cc001c8@baylibre.com>
	 <zdltaexty6pzbqesoluuyluygyt6w7nq7r2wccmtfktppwuw3e@qb36fsu3jq4k>
	 <0dd1a97e-ff7c-4d09-b18e-5df9944488c6@baylibre.com>
	 <p3ejuwktdxcjwv43nnap5tin33ziimgxfan2xoghtaaubsxgy7@tjmwjpwy6yy5>
	 <6b72e9dc9d574aa1f025c0f5d317dcec1d729ba9.camel@gmail.com>
	 <d2803c4a-d4ee-47e6-9bba-2d042051f980@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-05-21 at 10:05 -0500, David Lechner wrote:
> On 5/21/25 9:22 AM, Nuno S=C3=A1 wrote:
> > On Wed, 2025-05-21 at 15:54 +0200, Uwe Kleine-K=C3=B6nig wrote:
> > > Hello David,
> > >=20
> > > On Wed, May 21, 2025 at 08:19:51AM -0500, David Lechner wrote:
> > > > On 5/21/25 4:22 AM, Uwe Kleine-K=C3=B6nig wrote:
> > > > > Can you achieve the same effect with the (IMHO slightly nicer but
> > > > > hand-crafted) following patch:
> > > > >=20
> > > > > =C2=A0	ddata =3D pwmchip_get_drvdata(chip);
> > > > > =C2=A0	ddata->regmap =3D regmap;
> > > > > =C2=A0
> > > > > -	clk =3D devm_clk_get_enabled(dev, NULL);
> > > > > -	if (IS_ERR(clk))
> > > > > -		return dev_err_probe(dev, PTR_ERR(clk), "failed to
> > > > > get
> > > > > clock\n");
> > > > > +	axi_clk =3D devm_clk_get_enabled(dev, "axi");
> > > > > +	if (IS_ERR(axi_clk))
> > > > > +		return dev_err_probe(dev, PTR_ERR(axi_clk), "failed
> > > > > to
> > > > > get axi clock\n");
> > > > >=20
> > > > > +	clk =3D devm_clk_get_enabled_optional(dev, "ext");
> > > > > +	if (IS_ERR(clk))
> > > > > +		return dev_err_probe(dev, PTR_ERR(clk), "failed to
> > > > > get
> > > > > ext clock\n");
> > > > > +	}
> > > >=20
> > > > The trouble with this is that it would not work with existing .dtbs
> > > > that don't have clock-names set. I think it would need to be more l=
ike
> > > > this:
> > > >=20
> > > >=20
> > > > 	axi_clk =3D devm_clk_get_enabled(dev, NULL);
> > > > 	if (IS_ERR(axi_clk))
> > > > 		return dev_err_probe(dev, PTR_ERR(axi_clk), "failed to
> > > > get
> > > > axi clock\n");
> > > >=20
> > > > 	clk =3D devm_clk_get_enabled_optional(dev, "ext");
> > > > 	if (IS_ERR(clk))
> > > > 		return dev_err_probe(dev, PTR_ERR(clk), "failed to get
> > > > ext
> > > > clock\n");
> > > >=20
> > > > 	if (!clk)
> > > > 		clk =3D axi_clk
> > > >=20
> > >=20
> > > If there are no clock-names, the parameter is ignored. (I didn't test=
,
> > > only quickly checked the code.) So passing "axi" instead of NULL shou=
ld
> > > work and yield a more robust solution.
> > >=20
> > >=20
> >=20
> > Are you sure? If there are no clock-names and you pass an id, you shoul=
d get
> > an
> > error back:
> >=20
> > https://elixir.bootlin.com/linux/v6.14.7/source/drivers/clk/clk.c#L5198
> >=20
> >=20
> > I know it's not exactly the same we're discussing but
> > of_property_match_string()
> > return -EINVAL if the property is not found which leads to an index < 0=
 and
> > thus
> > of_parse_phandle_with_args() also returns an error back.
> >=20
> > I think I'm not missing anything but it's always a possibility.
> >=20
> > - Nuno S=C3=A1
>=20
> Testing agrees:
>=20
> Given:
>=20
> 	clocks =3D <&some_clock>;
> 	/delete-property/clock-names;
>=20
> And:
>=20
> 	axi_clk =3D devm_clk_get_enabled(dev, "axi");
>=20
> We get:
>=20
> [=C2=A0=C2=A0=C2=A0 1.190040] axi-pwmgen 44b00000.pwm: error -ENOENT: fai=
led to get axi clock

Hmm, so it seems I have no bug (in the other link I pasted in the other rep=
ly).
Looking at the code I would expect -EINVAL to be returned...

I guess it's because we still try  __clk_get_sys().

- Nuno S=C3=A1

