Return-Path: <linux-pwm+bounces-6071-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD37DABF7B0
	for <lists+linux-pwm@lfdr.de>; Wed, 21 May 2025 16:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB10A1BA411F
	for <lists+linux-pwm@lfdr.de>; Wed, 21 May 2025 14:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AFA1A0BFA;
	Wed, 21 May 2025 14:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jkz+Qred"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F99018B495;
	Wed, 21 May 2025 14:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747837343; cv=none; b=Iw+TYj/xk7xfxgHWTqisRNMZXHvFDkBU1RmOQt1E/Njr7XwCu/wlxQAT1F2VLBMrgQxBc5/T154SS4uAAqbOigk1k0nPnB/d635W678gfHTNTh5/TOcD5vUusK4DGe27F67Zd/ExxHABuuvpydgIm9ZHPvgEtqW2//bRQe44ARc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747837343; c=relaxed/simple;
	bh=F5hEzDUx2SkcS2gm/dMFSeK7fTbZnXqJHdiIjgBb3Os=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hWUKNqL5l4pa+33mnD9ty2TBINV45nW4mv+YpSYI3sXA3tltuvEsJz/PshWMiTnoZusBzGqtfJebNFvz3q12URc+rlCrE6VzFWq5ZzG96sBJ6HSZn1MmLe4mqdRGPsX2DTpRJmROSz+qn8IqZkGyMvhEB5poHogbfMac+wZ04pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jkz+Qred; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43edb40f357so57520305e9.0;
        Wed, 21 May 2025 07:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747837339; x=1748442139; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=s+jyCgbLr3xrcTJHsRt9Kq15QJhKLq4lab6/AE5okc8=;
        b=Jkz+QredGO3QBuu2nwxa9v/kMh2pYT8rWROslTKj7d4EOd7chBmo5etIfrAGJ/2+F3
         d0ZVv4qaag2DUTyQJpRIqXVLQT5drPL9r6U7u23Bg8ySEJK04he0CnEbTZXp+qa7RrXT
         miySCqy+xAHya+KtLJCnzAk2kMjw9aVGYuR8PbfRNI6/g3oxRfBlClw81Lb5AwFgRV15
         BpVaRDeD8/sZkDO8FwIMWftEhqLR7zY+olAG320JBd4xHRwmaxPjWGGr9tVXrIART05J
         vL1pR3/cBl80kAXCqedjGRV6I1SpVk/+rkHL/snr98ak6K3mqkZOYGsBeM9HWKkblG95
         FfqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747837339; x=1748442139;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s+jyCgbLr3xrcTJHsRt9Kq15QJhKLq4lab6/AE5okc8=;
        b=w5ZytPDkOTZH+c6qLUougUDhP6LxPUgyJ4re8oYxHyv/wAjalHPHE9bPn763RhXh8z
         lyAfNnxnV778QAZg2Hr/rAgPQnioj+KMZ3eco1MUvVHVtS9eQWKQqa048WssPDTGgzXL
         POL9Ko4euNh24muTRT6JKyLC6KwuekbmR/LOIbr4wvRl932qeb1rkbMSP37JmuPohM2C
         LnbXG/b1wGl3u1RxaiXQQm4grSXvbll44+HzSDPDQJWQJ2quPOl3jtbGbYOyQi89mx/x
         NvlruZC8pk/uVkJAJGe5AWC7l9w6ajWjcyVdvu2c8xcmifPI3cBPQlOH1bicU8RU1moB
         BTew==
X-Forwarded-Encrypted: i=1; AJvYcCU0XvuH7Yx7H2oCD/yyP3MT1a5M/Y2GTnG5MhOlfiEMmsMQ78XxfSTcjhrkJACnTCN5dfS246Tx/DB0@vger.kernel.org, AJvYcCUID+rU1grRewcNPb+7BYHpGAQ+c20udZJlrEo/LWlf1eT7Cs6KVDNmXWOfZ7j+SDkAzg+S77TgIjNu@vger.kernel.org, AJvYcCVYBrnGW24YoNIhXHJ6tkU/H8JBiC93dFvTvGvztCF3HoRX/IJiEbHckByb9VfxqhKcZPeB414VrJ6cIqCi@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8hXdJcDmrCGT47mbSXSP8g1r5phi9E8zO3vgEvZxh2bzQB/7u
	ZNyFdKhLeE9ubDPPN39yDmpuP11BjzJaRtER1KvQkzS643WMcqCQMuIw
X-Gm-Gg: ASbGnctP9hgISM4NWSP2J7s0JNb9T9y1R5BVNPv18yaai/udb75hF7r1NevgwWq9TfU
	BaXB1wECBMJ/jzbt5gwvAH+w0GNNhc4Im55RRCYlnOzuOyKdL3+ohEXa9pr2yy6u9mRWLJ4qwGl
	jZA+mSkMlllbpQza8wm28R51BdKqEFtfxHmigsn29AwNR3sRxCY3k8elsNjGWXJNE5ha2qhQw2X
	hHiPZw8ScFaHwf5XHfJvHdptYKugwjpzZ5g5GAXeoT+C+P2A84UhpHpOJI3R95iRHi8IG/wsSDX
	c9C05jiVVOn/osfuTqu/9u4yTRxgI/mgt4xfPVTseA1DlplaTds=
X-Google-Smtp-Source: AGHT+IHDyF8zBHr8bx3AfS49+niCmB110rPNtZqQRPC4oaWWGA8YQRunaD+V7VF8sSF1eGCeXaxB0A==
X-Received: by 2002:a05:600c:c13:b0:43d:79:ae1b with SMTP id 5b1f17b1804b1-442fd627416mr202152715e9.14.1747837339090;
        Wed, 21 May 2025 07:22:19 -0700 (PDT)
Received: from [10.5.0.2] ([185.174.156.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f7ca2dd9sm69237755e9.37.2025.05.21.07.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 07:22:18 -0700 (PDT)
Message-ID: <6b72e9dc9d574aa1f025c0f5d317dcec1d729ba9.camel@gmail.com>
Subject: Re: [PATCH 3/3] pwm: axi-pwmgen: add support for external clock
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>, David Lechner
	 <dlechner@baylibre.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, Nuno
 =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>, Trevor Gamblin
 <tgamblin@baylibre.com>, Rob Herring	 <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley	 <conor+dt@kernel.org>,
 linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 21 May 2025 15:22:20 +0100
In-Reply-To: <p3ejuwktdxcjwv43nnap5tin33ziimgxfan2xoghtaaubsxgy7@tjmwjpwy6yy5>
References: 
	<20250520-pwm-axi-pwmgen-add-external-clock-v1-0-6cd63cc001c8@baylibre.com>
	 <20250520-pwm-axi-pwmgen-add-external-clock-v1-3-6cd63cc001c8@baylibre.com>
	 <zdltaexty6pzbqesoluuyluygyt6w7nq7r2wccmtfktppwuw3e@qb36fsu3jq4k>
	 <0dd1a97e-ff7c-4d09-b18e-5df9944488c6@baylibre.com>
	 <p3ejuwktdxcjwv43nnap5tin33ziimgxfan2xoghtaaubsxgy7@tjmwjpwy6yy5>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-05-21 at 15:54 +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hello David,
>=20
> On Wed, May 21, 2025 at 08:19:51AM -0500, David Lechner wrote:
> > On 5/21/25 4:22 AM, Uwe Kleine-K=C3=B6nig wrote:
> > > Can you achieve the same effect with the (IMHO slightly nicer but
> > > hand-crafted) following patch:
> > >=20
> > > =C2=A0	ddata =3D pwmchip_get_drvdata(chip);
> > > =C2=A0	ddata->regmap =3D regmap;
> > > =C2=A0
> > > -	clk =3D devm_clk_get_enabled(dev, NULL);
> > > -	if (IS_ERR(clk))
> > > -		return dev_err_probe(dev, PTR_ERR(clk), "failed to get
> > > clock\n");
> > > +	axi_clk =3D devm_clk_get_enabled(dev, "axi");
> > > +	if (IS_ERR(axi_clk))
> > > +		return dev_err_probe(dev, PTR_ERR(axi_clk), "failed to
> > > get axi clock\n");
> > >=20
> > > +	clk =3D devm_clk_get_enabled_optional(dev, "ext");
> > > +	if (IS_ERR(clk))
> > > +		return dev_err_probe(dev, PTR_ERR(clk), "failed to get
> > > ext clock\n");
> > > +	}
> >=20
> > The trouble with this is that it would not work with existing .dtbs
> > that don't have clock-names set. I think it would need to be more like =
this:
> >=20
> >=20
> > 	axi_clk =3D devm_clk_get_enabled(dev, NULL);
> > 	if (IS_ERR(axi_clk))
> > 		return dev_err_probe(dev, PTR_ERR(axi_clk), "failed to get
> > axi clock\n");
> >=20
> > 	clk =3D devm_clk_get_enabled_optional(dev, "ext");
> > 	if (IS_ERR(clk))
> > 		return dev_err_probe(dev, PTR_ERR(clk), "failed to get ext
> > clock\n");
> >=20
> > 	if (!clk)
> > 		clk =3D axi_clk
> >=20
>=20
> If there are no clock-names, the parameter is ignored. (I didn't test,
> only quickly checked the code.) So passing "axi" instead of NULL should
> work and yield a more robust solution.
>=20
>=20

Are you sure? If there are no clock-names and you pass an id, you should ge=
t an
error back:

https://elixir.bootlin.com/linux/v6.14.7/source/drivers/clk/clk.c#L5198


I know it's not exactly the same we're discussing but of_property_match_str=
ing()
return -EINVAL if the property is not found which leads to an index < 0 and=
 thus
of_parse_phandle_with_args() also returns an error back.

I think I'm not missing anything but it's always a possibility.

- Nuno S=C3=A1

