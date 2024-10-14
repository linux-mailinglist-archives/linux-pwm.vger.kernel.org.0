Return-Path: <linux-pwm+bounces-3640-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F10AA99D7DA
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Oct 2024 22:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D986B20C23
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Oct 2024 20:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942531CF5C0;
	Mon, 14 Oct 2024 20:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bFNy/FGK"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F891CF2A2
	for <linux-pwm@vger.kernel.org>; Mon, 14 Oct 2024 20:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728936346; cv=none; b=Yhn0HSNa9hm965TUYXJuo+M9RTKMMfXXo/pe4i/QUfWu1Uy0SF2Wlchj2P2uP0hlOffenwIS8ce1tt51M8Vu2lKga2ArpIvpCpa8h29oudigeg9eoxg2ZyfCJwt1WriH8J+9f4mM0fuGgocsoh7aDehDXbdGk14LDYo/xIYOLz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728936346; c=relaxed/simple;
	bh=/p0fsinLEF+6jqle9DFYB7wdd7XNPvVlqtJXR24v4JQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xcyg7VGf/Bj7KC3kUHyd3natr9I2MKAXeOA5JEcaSNGPj6PKua5qZDfQkWOO+A43YZgKizZEDOpWyIZ6lZbH9Rr/EMuVq8nkolzjC9PsWFM4h8DZBqFzNC4cZa3kaFa/WH5IGZuJuHqfSCMp+8cSgUqYh43A4wjP7kFv+/h4mf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bFNy/FGK; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d4a5ecc44so3301060f8f.2
        for <linux-pwm@vger.kernel.org>; Mon, 14 Oct 2024 13:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728936343; x=1729541143; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/p0fsinLEF+6jqle9DFYB7wdd7XNPvVlqtJXR24v4JQ=;
        b=bFNy/FGKbuW8mqxxfuPRBmPajG5CWHd19UEPFs1T8mG3DI6lkasD5ru18XmRvhH7j6
         s+kuFpSuzJ/8jiGYai9w2Yjo/A2qXDep/XkdknD481d/D9yhHn1U81SXYJncrtgW6EK3
         cxgwMQb5SPi3kYJ4CbXuDdFL+btv9O8Gzw5KD2wmPIFT3wJAYcIQB9GtsS+mWpg1BWQl
         sz28upbeggmdlQuEYDjaj8sO0qAaObHMGpW543gkAvtlX71j+EJ46kw2tUeoSkhCHfH6
         EknILaN41mbKoJL1fQ+hnAj4sDDrCgk11zpKNgrqQJiWvA8Dei1H7AzqJlvInHEAFbTm
         Ax7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728936343; x=1729541143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/p0fsinLEF+6jqle9DFYB7wdd7XNPvVlqtJXR24v4JQ=;
        b=iDgCNnID2rCqwSrGPUFexhYuMMba6aUrcJ8oa99lptvRekbStxjVS+1DKsFQmVxgYM
         f7PIF3b+hoV95HMqkrzdoLXVHAnNQORD5mJxxQl8O0P7oKSXmP+cf0Ab7a/NoF6/oABv
         Ins7AFbr/uQDyblf68928keNBYxSLNmLacruWoumdX7iwAqDIRrXKTBqK5UPrvGw1mWm
         Qe121ePbmwnq9n25l++SpuyAHrxA1g3WHBDDOV1R5SdArntnYVQtZqzo0UC/UCmSUrtX
         yjxEJCg2W1u+i+bEt6dyI7OKaA0tgFUvXJUqPhgWbWochW0TtiTl0pNL60Sj3n1lGb+F
         dcYA==
X-Forwarded-Encrypted: i=1; AJvYcCVa0197NgEgQvO4G1bsLw21VDTc0RKYG38Zq7owSUUUk5aSGJc9QZ9bDZFuzm/qj3MKqh7NM3bhKd0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwkivm03plFxiO+EpywI7Dr2Oh2nsl+kytOKbT82M76lTVm6CI
	hTJcTJuBwct1dq22F43QKekGv+7tuR3Zl7oEz6yeHdrpTzbXotLSZYjX5lCAI3A=
X-Google-Smtp-Source: AGHT+IFOPR8MYYQWwDkLVexcUVJZet9k0gP7hpDIjbBtdgwb/++D2QZVJSpb0Xd1vOfW2SNUD6dHNA==
X-Received: by 2002:a05:6000:cf:b0:37d:5133:8cba with SMTP id ffacd0b85a97d-37d55204527mr8720364f8f.20.1728936343009;
        Mon, 14 Oct 2024 13:05:43 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:9cc:1a74:296e:df4d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b9180adsm12253910f8f.112.2024.10.14.13.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 13:05:42 -0700 (PDT)
Date: Mon, 14 Oct 2024 22:05:40 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Thierry Reding <thierry.reding@gmail.com>, 
	"open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, 
	"moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, justin.chen@broadcom.com
Subject: Re: [PATCH 0/2] pwm: brcmstb: Support configurable open-drain mode
Message-ID: <2lxrtu6mnzs4v6h3x7skbmxwtdmhgn7g3qmmxyr5n4lof6lkb2@6rfckn2g45ho>
References: <20241012025603.1644451-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="74noghsmn7dtdnbd"
Content-Disposition: inline
In-Reply-To: <20241012025603.1644451-1-florian.fainelli@broadcom.com>


--74noghsmn7dtdnbd
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 0/2] pwm: brcmstb: Support configurable open-drain mode
MIME-Version: 1.0

Hello Florian,

On Fri, Oct 11, 2024 at 07:56:01PM -0700, Florian Fainelli wrote:
> This patch series updates the pwm-brcmstb driver to not assume an
> open-drain mode, but instead get that sort of configuration from Device
> Tree using the 'open-drain' property.

Just for me to be sure to understand correctly: A kernel without your
patch #2 behaves identical to a kernel with that patch if the open-drain
property is present, right?

It's not clear to me why totem-pole is the better default and the commit
logs don't justify the updated default. Can you improve here?

Best regards
Uwe

--74noghsmn7dtdnbd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmcNeZEACgkQj4D7WH0S
/k5NLAgAnE0plbMtCwz2Wv6bQ8vEDVdoNHD3hCUdvomaNZPj5Dy1f0/u2J5Hj/NW
KRn/AUbVCJYGa4LQ+7MJ5VMLY8GGeAYgpv1jdnBMJJX9yXp1Hwovz8akFV1Hc8LI
fQPoBICMk+bVDNB8j5iFplnH5G5cDespFv56Nns0ImOp3maL5CjojP1RZmUsayM6
3RQafWpyPIkhuI4mrjAtGSAoLoWig7E08ZD2UPIs0vw9phZEB08fUhW6CGf88pev
fNHViOI4wyumI7l9RO2LvotnV1syhNy052zzgM1e43WwxosYhKfG2xmbGRaOTkGT
P/6yQseolE3vX7bwd14iAgbYEmoY5g==
=fdY+
-----END PGP SIGNATURE-----

--74noghsmn7dtdnbd--

