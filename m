Return-Path: <linux-pwm+bounces-4590-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 135FAA0B540
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Jan 2025 12:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BCEB167781
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Jan 2025 11:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70CA822AE7A;
	Mon, 13 Jan 2025 11:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKBCFwat"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B9E14A09C;
	Mon, 13 Jan 2025 11:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736767043; cv=none; b=AAjzNEBdHhZXA8iC7SPHSOSiW51KBLBWnIbgHr2vDp01bTYL/YFq4nNMZlZjenbEOo88Cz3IQetAwAqoGV6xoBgBGsJAnWi+RQKJwqXTonS+O7QQLiLNqibvA9gVpMjs/nVKT8LG2xOQKtshojhN9mBJFEjSO9c97X1yUqJ1ar0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736767043; c=relaxed/simple;
	bh=jShLxB6yPTKBOffN+oc3LtPY0zNdtJZKcpS+cUCWfO0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uXanfItJqh6Fb98e5xtn6SasHraUceYqlnIGliUE8YhbYELz3drz27WCvUwvFFxyj0DjBUajEYcNuGB6y6p1xaF6GqSzvtlsI++kD8Cj1r4mXcCQISf3PviFCtReOJbj9/bPnkdlg7ycOssgZJUhoGeztPce9ITUUDvuxbH/Tno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GKBCFwat; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3862d6d5765so2246063f8f.3;
        Mon, 13 Jan 2025 03:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736767040; x=1737371840; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jShLxB6yPTKBOffN+oc3LtPY0zNdtJZKcpS+cUCWfO0=;
        b=GKBCFwaty6iAsC9dyDocQUCXKl24A1NdXpqXq+WvclF4n/Ys+9rzWor3n960sbL2jr
         lJXde7pAIwxfDw8qYTKL07wQM3niaqtnkZrMIiziMgJIqUUqlKEFjR3kiGJeLwrYIZRy
         18hZZUsyUVJvestqLrnCFHvHZXEHkT9kpTv4BqmMCdK7417BmRlK+64gnveuNSjGngOA
         hA9nPc/BXpkQeyr94ir19bk1ldPOuIgnSSGtPRPYSWn4uGHp45vV9psJmaTD4e5U6/9y
         X5prsXssbgkCIaZHXX8BXYlHXtOqeTXZKso6+c4H2395HPFeHqxnMuabNv/qwHDY84jW
         xSig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736767040; x=1737371840;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jShLxB6yPTKBOffN+oc3LtPY0zNdtJZKcpS+cUCWfO0=;
        b=djTaiwMXFYYZamWlXULKOtTQCCTDlvtPB+4bskF3x9dqnlqaNfL2BPodrWoIVY2JWY
         6UT/sUe0kOXmPZduEXh1qbbJIt5BscKPyib+ySKpRJUQpWfKtRvJWCEBEvUbUgtwu3AB
         NWstubLHOD3g+oAZccxCjaaOJwvdtYtwitgfg5I3SQyv8il3lgmbCJy5EcmchxYIzCwT
         eaLStmfT5vJOrimhbWdME+6PkfM+uZAmXqUx1n083IOE0jsXq6TUBTZ5fA7flNX8L6Yh
         833+3EFOabd5nCfDJ3eefJM8JxSlykG4yFQbtrNL4MyCLj9K7C4yh+mMwBDIJIHI1kCb
         okOA==
X-Forwarded-Encrypted: i=1; AJvYcCUNPl03U86+fXnKV3hLKWgw6kMsvcAiMD54JLK9pZ7Ssi5I+CTTz0D4OH/NsMJDvfmsrQopg5QB96toHbxS@vger.kernel.org, AJvYcCVI5DUQpJYvhRKuovuT4laqW/Ioc7n0UIVQQiaK90ONioP991momQcVVKc57fKgXyclVHC5ltl6jm18@vger.kernel.org, AJvYcCWCGcxg2SGfPHZlOhhiNkt5MXJxvKfy/TCCpo04pNK0U2GcMHmUE7QzK+z+Vqo2GRjOBoZzqdMpwZtw@vger.kernel.org, AJvYcCXw/n0K3FEtX95DsKBgaRc9b/PGuaAYdhyKJ6bClS9jjvFwih0do5H0ZAdvtX4Iq4BcDmv8EBHcpUOs@vger.kernel.org
X-Gm-Message-State: AOJu0YxKVIECZXbqxVX+LfjPCi/mLXIGPdVPIevxuoYdC8LC5NqE2XjQ
	FKVgdA7vxXThW08khdZ7aybIsr64jRbRFbNuj8rKqrPq/SjfA+yP
X-Gm-Gg: ASbGnct89vIX+f3Sl3+apZ7bj6ZEN/VwIS/i1URw4aJvp/37YqFFdBCcMVEzdjuSdNg
	9sbB+KaivB5CMEcIIQtQE5HKVaCYEKMIVVCHYu2jIG77kcEDQXaiChqzc9TLaFubvPkXJJWtogm
	tYbUR+xZ4qHspiR1CmT4CMXK/Tm2izRMcxFqr+pgrBhxXiPMcyi4KzQvPmuFO17r13ZE+cImM66
	JZFj5uIrbtiZhvQqNJIML9ckgH382w5ev6jhilpNR0EVcyd30xcPxVcmLA3jjtgDUzaCIEIOdGg
	EcwOpSS34e0WrDYUkD96tv16pLVZ
X-Google-Smtp-Source: AGHT+IEyulpb6krnjq+a6pFe00X75S3dCfDh4t+ulX+aMtZchEnDU1cZXPTsuZ7vYdkSHBJALIwjEw==
X-Received: by 2002:a5d:5f52:0:b0:385:fcfb:8d4f with SMTP id ffacd0b85a97d-38a872deb1amr20375594f8f.21.1736767039711;
        Mon, 13 Jan 2025 03:17:19 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436dd14dfcasm165138065e9.1.2025.01.13.03.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 03:17:19 -0800 (PST)
Message-ID: <98dad0cd3ba55411797c1871c5ceb5f656b8225b.camel@gmail.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: iio: adf4371: add refin mode
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Antoniu Miclaus
	 <antoniu.miclaus@analog.com>
Cc: jic23@kernel.org, robh@kernel.org, conor+dt@kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Date: Mon, 13 Jan 2025 11:17:18 +0000
In-Reply-To: <499ef047-d3fc-4d2a-ba7d-342ff08a351d@kernel.org>
References: <20250109133707.3845-1-antoniu.miclaus@analog.com>
	 <20250109133707.3845-2-antoniu.miclaus@analog.com>
	 <mr7j4znl63p3ldhrxpc47mio63deszpqswbsqxxiby5nftpgbr@b4h47yp3xev5>
	 <2f483161cbe1f797a9095ca3c9f4f472d3785acb.camel@gmail.com>
	 <499ef047-d3fc-4d2a-ba7d-342ff08a351d@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-01-13 at 11:21 +0100, Krzysztof Kozlowski wrote:
> On 13/01/2025 10:55, Nuno S=C3=A1 wrote:
> > On Mon, 2025-01-13 at 09:37 +0100, Krzysztof Kozlowski wrote:
> > > On Thu, Jan 09, 2025 at 03:37:05PM +0200, Antoniu Miclaus wrote:
> > > > =C2=A0=C2=A0 clock-names:
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 description:
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Must be "clkin"
> > > > -=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Must be "clkin" if the input refere=
nce is single ended or "clkin-
> > > > diff"
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if the input reference is different=
ial. By default single ended
> > > > input
> > > > is
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 applied.
> > > > +=C2=A0=C2=A0=C2=A0 enum: [clkin, clkin-diff]
> > > > +=C2=A0=C2=A0=C2=A0 default: clkin
> > >=20
> > > Which pins are these? I went through adf4371 datasheet and no referen=
ce
> > > on clock inputs like clkin or clkin-diff.
> > >=20
> > >=20
> >=20
> > Hmm, I guess we should call this 'refp' and 'refp-n' then (the latter s=
eems
> > a
> > bit more odd)? Or just 'ref' and 'ref-diff'?
>=20
> That mistake was done at the beginning - the "clkin" is just useless
> name. It cannot be "clkout" and it cannot be anything else than clk, so
> it is 100% redundant.
>=20

Oh sure... Makes sense and I forgot that the property is not new...

> But looking for pins brought second point - here you claim these are
> mutually exclusive while datasheet suggests that both inputs can be
> connected. Unless they come from the same source always?
>=20

If you have a single ended input then only one pin (the positive one) will =
be
used. If the input signal is differential, then both pins will be used. So =
they
are mutually exclusive... You either have single ended or a differential in=
put.=20
And depending on the input type, the limit of the input frequency varies.

- Nuno S=C3=A1


