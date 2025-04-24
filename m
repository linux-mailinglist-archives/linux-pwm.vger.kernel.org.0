Return-Path: <linux-pwm+bounces-5701-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 639C9A9B6BA
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Apr 2025 20:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7228927582
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Apr 2025 18:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5AA1E5B9E;
	Thu, 24 Apr 2025 18:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYVDXFZR"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B364F155342;
	Thu, 24 Apr 2025 18:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745520678; cv=none; b=H2ueiM7pHNog6fODgWOZxM2muWs9wE2/bfTAAYZqUusN4oAth0X8+G2xzC3+8JjSsWVTo6L+qrTPufCzsTFcKRBI/6/a7p53dULv3l/N1nhBO0fYX6tekfHKxpItC6FktLeK1fOEGwvt0izWhuY23IEJ5Mj0+iKG+uzT8LeTv9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745520678; c=relaxed/simple;
	bh=jrLR87TxKkULAUzRb82LBjgFYsNOFpUoRY9Ekxhdyhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b7Z2aXe+5OYZyC1prUuqmQeCqLeDZlo2TBMpwhXMiT0mVIEXuWTywjk7GiuU7c3j87QbEwG2eLbCL2MEMHv5w43jJNdGu/HXrwrxdE7Ez8GBrOetSnT3wOqauGzdVWD6/2RFZt9wEjGAGjhtD4zi8F1RDbjliKLNwP98xGbHahU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gYVDXFZR; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-afc857702d1so1218699a12.3;
        Thu, 24 Apr 2025 11:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745520676; x=1746125476; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VfLYpHX9qwdgq0NabU5S/kr3j2tU7u4rdF6ed5atRmU=;
        b=gYVDXFZR8+vdizrIGwSIC5vnz+DQr1dJ5Q2nnnxG3WuBiLDQDxz8ljFziBwun7yvOn
         /WDNGtlzZOLkJ82ckZVfwOMapNJ2H6KkJBx1klVoK/SM9ffQ46g2COuGnPdRTvIIBZ0C
         +5eeWEkVdgPJi/Cy0e8k+l19invzZkTSYfO4oy68pGm4+HLc9Fceo3Ilj8KyQSqeULQ3
         /k7TJxZ5s7J/lb9VZLhTVfRdLxT5QojRTOZ65lZ3J9glLlw2Aprf1mSUET2X8tCVqCCw
         lhXMb3jbHmH7wijPiXTewz14f8DLHOVM6daLtUCUL53kJMUEm726LUlogrnXHqq+nJDf
         SIbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745520676; x=1746125476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VfLYpHX9qwdgq0NabU5S/kr3j2tU7u4rdF6ed5atRmU=;
        b=JPt4edFZVRAOvGX9n6Yh2Uf3olu1hNal80bBkaSEXD4Qi9Shh54aH68enBnnKHrV97
         7lDIBLqYxciF9e5BPPmDnR7ZnZmLNBjzmxLJd/zwtpcxp2pCweCmdq/o8YgAoePQdUdq
         7Vi3WwfISCWPjc9O+ti/MglianLRuu96BBdM4U7ZKcVgXJgZMXk7KtCHklxKf73SQt/C
         aqQJ7PdctBbCEkkH71Yx02Pyw0I+UkO5u9CnrnKTqMI463LeKhFr4DmcEbw4aX4HRegF
         iXWYWtW5aLnX6mB/IJeaLlWt5eEznSME3IBn0T4NqmsX00s850RU/1tBqxUVuYmWGcRw
         +0bA==
X-Forwarded-Encrypted: i=1; AJvYcCUy/SSzHZKpLl1Vsfd98uAECHC3qUBn5ciKkjycNLJlyKjOt/Hsf69CTFqyVWhmbpfg0PnvBogw5lDURYy3@vger.kernel.org, AJvYcCWX7dhWiXfluuQUZMZtkJDwgCLoDbelcGjfYUJw4lJEYrczJRwfeJrF/7n2yDGjviNEhYxD62LoqUVx@vger.kernel.org, AJvYcCX0JfaBkEhxX9ftrAQHMHAEP6QcHwp8mrlwNRKyhHFqxTL7rcsfSjSY7cHGmzGrJLNHtp7/n5evyJDw@vger.kernel.org
X-Gm-Message-State: AOJu0YwH5qxWCNAHWR2TnB5ascSh9C+dWsFU1WiR75dKIClpQQjNczZO
	jYbMKkTmNGQGEg6aYvwOf4CSHnxru2Zra/e5PHB5hJSjtAUqmLlvjaG779DYeWE/MXlWoF1Yo6I
	1DHOuj3n7O9gZN8JB0XEpVcll6T0=
X-Gm-Gg: ASbGncvROWjJlaxRvOsj27FqB0ANS9mSwAEuGGX2dxo/m3D8k6JPZjUn6C0MKBRLSza
	VGY+Qguu8ukOnXgyXdq5hhCHi+SowffiWeX0iQbvd5BlD3llRxhNVcIOW9GlMPzLLjuG6lbFUI0
	aJH7LXOd3M46z/H7Qy1cXfhvj14PdUHxv/MP7zyb9ps4uhaU1zDnukG2Q=
X-Google-Smtp-Source: AGHT+IErzNhSKSe/EMOcOw8cgkaJx5hBvqgDwBFf4ML//KAkMZG3deVxwQsFmQjZnlOQSskcoEfOL2Ba7r+EndHMZBs=
X-Received: by 2002:a05:6a21:3a8b:b0:1fa:995a:5004 with SMTP id
 adf61e73a8af0-20444f2552cmr5669561637.26.1745520675917; Thu, 24 Apr 2025
 11:51:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418-via_pwm_binding-v2-1-17545f4d719e@gmail.com>
 <yscledgclp2v4p7djwrszbc3dnqifkcofky7rugkcip7o2rmof@xljfd2kfyzzs>
 <CABjd4YxK+4kEeS_tKBi9zhj85y6U1Dgi3nJNuQ8hfkeoY+iK1w@mail.gmail.com>
 <eydewrcn4tviu6fbqmmvhoc2zao3uzrxwwlc55tuxuhfrexk5k@7xg5fdeu7wun> <aokv26x67eu3fhkcrtdo4suoz2lryb5x5u4m4xeycwlpgt4njs@7idth75voi4y>
In-Reply-To: <aokv26x67eu3fhkcrtdo4suoz2lryb5x5u4m4xeycwlpgt4njs@7idth75voi4y>
From: Alexey Charkov <alchark@gmail.com>
Date: Thu, 24 Apr 2025 22:51:23 +0400
X-Gm-Features: ATxdqUFHUIJ7L8t27PgxByXvB2He_6LJ80dx71hPLB_GXjgdvnvl0ZNmvLuD-0Q
Message-ID: <CABjd4Yy=M+YCiVNF3OaTeQvR+_Xk9oEMBTq0JjxbLTtA1zUiaQ@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: pwm: vt8500-pwm: Convert to YAML
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 4:48=E2=80=AFPM Uwe Kleine-K=C3=B6nig <ukleinek@ker=
nel.org> wrote:
>
> On Thu, Apr 24, 2025 at 02:32:33PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> > Nevertheless I'll play a bit with patatt and your key.
>
> FTR, it wasn't complicated:
>
>         $ keyringdir=3D~/.local/share/patatt/public
>         $ mkdir "$keyringdir"
>         $ git config --global set --append patatt.keyringsrc "$keyringsrc=
"
>         $ mkdir -p "$keyringdir/ed25519/gmail.com/alchark
>         $ echo "ltKbQzKLTJPiDgPtcHxdo+dzFthCCMtC3V9qf7+0rkc=3D" > "$keyri=
ngdir/ed25519/gmail.com/alchark/20250416"

I believe b4 can make this even a bit shorter:
https://b4.docs.kernel.org/en/latest/maintainer/kr.html#b4-kr-show-keys

> After that `b4 am` told me:
>
>         =E2=9C=93 Signed: ed25519/alchark@gmail.com
>
> for your patch \o/

Great that it works! Thanks a lot!

Best regards,
Alexey

