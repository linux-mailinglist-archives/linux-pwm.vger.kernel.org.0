Return-Path: <linux-pwm+bounces-5821-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE97AA9369
	for <lists+linux-pwm@lfdr.de>; Mon,  5 May 2025 14:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C49D7A7995
	for <lists+linux-pwm@lfdr.de>; Mon,  5 May 2025 12:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD4924C676;
	Mon,  5 May 2025 12:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lh43WOsZ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EFD1D90AD;
	Mon,  5 May 2025 12:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746448810; cv=none; b=bXSfNn/h2/ksSgXyrgOI3FmiCLjLyYstHZL0ZvC1Xc2vfWxMiXqi46F5cDSUbWcuYvSsc6LH/3wy1IUkAcV1KOkbP0Vt0yledYHZyz4LAIOCIMRhK5H4CQM1StPc9nZKJrNbZk+I3dgKwUaQpshMfoxrpdZFYgc15Mq/kNKNlgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746448810; c=relaxed/simple;
	bh=+l5QMNdWfOkTyKNuocxXGlDi0g0ak1uJulUAYBImkME=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YIfYILdIveIsRy+CRJ+VnbvogPmc6lcw8loJrHVlh52hUzZgLH/XTNJX563NHragZr0N1qxurabQRcMppBMH5n76ycM2p04t2uTJc1Fq76ZOL6+OINI8S0jk/0dgpbuLP4Nkhay0TP8RQyrVHGb0ytuxJERm6Ottkrcq5eiRkuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lh43WOsZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89946C4CEE4;
	Mon,  5 May 2025 12:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746448810;
	bh=+l5QMNdWfOkTyKNuocxXGlDi0g0ak1uJulUAYBImkME=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Lh43WOsZhSC85dGT+f6YIPJ5XLimZj4oCgxRLSMCPnKC+ubp2hB4XlSTRUsRdz+mY
	 uBnCPihBmgJ0nclXMjUfoaQjNytmljFhTAe7qr/0TSvUe77kH4a65kemBX1ZrM3JfL
	 PKXhoU7oRnT0ALrtNjD3phEcHHyQg7AMWcVuNshGr4Xz0qlw1/6ChEhq1S5ZD8MiRv
	 fIDFQa0cPbHNOEP8i3mhtBfqQgPNTzYvooGQJ4dw39xDWJKRBYXRbxKpKFzo4JIdek
	 Ba6m3lGKqF2BvWcUhnmNxr1ItirO9wzA5oV4BNNKQ/92Wq0qjw9nTb5/MYJaYzv0pP
	 63C1Dl59xzlSA==
Date: Mon, 5 May 2025 13:39:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Jorge Marques
 <gastmaier@gmail.com>, Andy Shevchenko <andy@kernel.org>, Jorge Marques
 <jorge.marques@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <ukleinek@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 1/5] Documentation: ABI: add oversampling frequency
 in sysfs-bus-iio
Message-ID: <20250505133958.01dffb57@jic23-huawei>
In-Reply-To: <CAHp75VcZM+4Br2-RMKZixEd1=x3_exbWZkEFw1U_NrFtsejkUg@mail.gmail.com>
References: <20250422-iio-driver-ad4052-v2-0-638af47e9eb3@analog.com>
	<20250422-iio-driver-ad4052-v2-1-638af47e9eb3@analog.com>
	<aAe6u6NhAsgjaL5_@smile.fi.intel.com>
	<c3i7g273lgvx7rpihzq6r7exxxnglbwrqwfryyz6ciqo52tszf@cvi7pz4bmkvq>
	<5aa4d76f-6f16-40ae-9dbf-767c63aa0a3d@baylibre.com>
	<CAHp75VcZM+4Br2-RMKZixEd1=x3_exbWZkEFw1U_NrFtsejkUg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 30 Apr 2025 01:03:07 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Tue, Apr 29, 2025 at 6:40=E2=80=AFPM David Lechner <dlechner@baylibre.=
com> wrote:
> >
> > On 4/29/25 8:47 AM, Jorge Marques wrote: =20
> > >
> > > Hi Andy,
> > >
> > > I agree with your suggestion, and in this case the appropriate kernel
> > > version is 3.10.
> > > =20
> > >> =20
> > >>> +What:              /sys/bus/iio/devices/iio:deviceX/oversampling_f=
requency
> > >>> +KernelVersion:     6.15 =20
> > >>
> > >> Then why don't you put the real version of the first release that ha=
s it?
> > >> =20
> > >>> +Contact:   linux-iio@vger.kernel.org
> > >>> +Description:
> > >>> +           Some devices have internal clocks for oversampling.
> > >>> +           Sets the resulting frequency in Hz to trigger a convers=
ion used by
> > >>> +           the oversampling filter.
> > >>> +           If the device has a fixed internal clock or is computed=
 based on
> > >>> +           the sampling frequency parameter, the parameter is read=
 only.
> > >>> +
> > >>> +What:              /sys/bus/iio/devices/iio:deviceX/oversampling_f=
requency_available
> > >>> +KernelVersion:     6.15 =20
> > >>
> > >> Ditto.
> > >> =20
> > >>> +Contact:   linux-iio@vger.kernel.org
> > >>> +Description:
> > >>> +           Hardware dependent values supported by the oversampling
> > >>> +           frequency. =20
> >
> >
> > I don't see oversampling_frequency used in any existing driver, so how =
could
> > it be introduced in kernel 3.10? I think you confuse it with
> > events/sampling_frequency.
> >
> > oversampling_frequency is new and so 6.16 should be correct if Jonathan=
 picks
> > this up in the next few weeks, otherwise it will be 6.17. =20
>=20
> If this is the case, the whole commit message should be revisited.
>=20
Yeah. That last bit about the existing drivers is talking about unrelated
ABI.

Jonathan


