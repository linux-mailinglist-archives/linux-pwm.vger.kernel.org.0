Return-Path: <linux-pwm+bounces-3615-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5137F99B4F1
	for <lists+linux-pwm@lfdr.de>; Sat, 12 Oct 2024 14:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0A5E1F2286B
	for <lists+linux-pwm@lfdr.de>; Sat, 12 Oct 2024 12:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B99018453C;
	Sat, 12 Oct 2024 12:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q7rOlrTF"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4991F1F5FA;
	Sat, 12 Oct 2024 12:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728737326; cv=none; b=US+Nh5BgSMrw5u/qOLOLz5L6rHy6TI2fTMHH29Enbr0MyYN0HmrmKehLwztv0cR60T3ao9OlbnhHKDF8l5uGV3bZacargtIW3SEVyn5SWpnrGLmHg5fE1mCXvgV84T1lL9NAR42RdD6M/fzpPcLmGhROPZGvvGfeQfChZkgYBf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728737326; c=relaxed/simple;
	bh=kEHSPvWvZBqgdTZFy+tP0oWL6gH6iFh2YX2nHzfWWqM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j3wd28P88JWXdidHI/aAEfCDObyU0vpx4EsMUUczZfWnh765Ueq1qj6NK9gwD5sd49pTFI1MbIgrC65FNT5aXK/d1r7A/PUG3bQTyHPLLIT38rZqjhbYmBD+y7v3dbDnxuS2HoextnW3uDnsIM+f0fgUASEWLOCIyTGH58iCXYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q7rOlrTF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A749C4CEC6;
	Sat, 12 Oct 2024 12:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728737325;
	bh=kEHSPvWvZBqgdTZFy+tP0oWL6gH6iFh2YX2nHzfWWqM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q7rOlrTFiXnLisjmjCE7GIIup2AbY82CuRDY4hyYlMPLFUSbKgEv1aAf4TNfH4a+9
	 wOPTir+U+zi9juEBWzdH5N6wMSRLbBJHWCR7LWsdry3ta0vuk+hYgfh0kK69eyI+YG
	 7FpmkVNM0iBNY/yA2swQGaAYev87YBX6cs6xYQJvQUHqpaH+Si6WiU/iEntw+/+Q6u
	 1KtR+/NS2GW25tL0vjLBr7VB19p457skL8zJnypB4fJsznhldjzV06KO91+mYSOezg
	 ZpLIqo9MjvDDr3yBd7YXN7MORvMhc1j8sygpIQqN91TavjFt8keqxR3SlEocElxJlj
	 MBVo2ypKDoutw==
Date: Sat, 12 Oct 2024 13:48:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Guillaume Stols <gstols@baylibre.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5p?=
 =?UTF-8?B?Zw==?= <ukleinek@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-pwm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, aardelean@baylibre.com, dlechner@baylibre.com,
 jstephan@baylibre.com, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v4 8/8] iio: adc: ad7606: Disable PWM usage for non
 backend version
Message-ID: <20241012134833.31531e18@jic23-huawei>
In-Reply-To: <bff897a52650dbd499a83d955645cbc2290f80ce.camel@gmail.com>
References: <20241009-ad7606_add_iio_backend_support-v4-0-6971a8c0f1d5@baylibre.com>
	<20241009-ad7606_add_iio_backend_support-v4-8-6971a8c0f1d5@baylibre.com>
	<bff897a52650dbd499a83d955645cbc2290f80ce.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 09 Oct 2024 16:45:40 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Wed, 2024-10-09 at 09:19 +0000, Guillaume Stols wrote:
> > Since the pwm was introduced before backend, there was a mock use, with
> > a GPIO emulation. Now that iio backend is introduced, the mock use can
> > be removed.
> >=20
> > Signed-off-by: Guillaume Stols <gstols@baylibre.com>
> > --- =20
>=20
> Maybe this was agreed on the previous iterations but I wonder if we shoul=
dn't just
> bring PWM support in the same patch as backend support is added...
>=20

I can't remember why we ended up in this position (might have been me
who asked for it!) but I'm fine with the logical steps we have in the
series, and it will all merge together. So probably not worth rethinking
now!

I took another look and other than the stuff Nuno has raised this series
looks good to me.

Figures crossed for v5 :)

Jonathan


> - Nuno S=C3=A1
>=20
>=20
>=20


