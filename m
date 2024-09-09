Return-Path: <linux-pwm+bounces-3168-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 537669715A0
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Sep 2024 12:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DA0C1C21CF5
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Sep 2024 10:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7201AD3F3;
	Mon,  9 Sep 2024 10:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b="B9hZXO59"
X-Original-To: linux-pwm@vger.kernel.org
Received: from forward502d.mail.yandex.net (forward502d.mail.yandex.net [178.154.239.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3146B191;
	Mon,  9 Sep 2024 10:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725878974; cv=none; b=kMOzu+zpQu+8Jl7x0SwqRMlpcl0ERp2Cs+Jzdh3pVyE8X5RyLzfeWrAAqoBBqTOR3swD+dnLXqv89dQYvRGN1kZT113ep+uNaWld1PWFTr3uBxvVEDAnb0DxPIEanPPl3EEBqPlW489yEmyuFuJyNiYEOnKVbYkhRtC1I6DzNhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725878974; c=relaxed/simple;
	bh=bt2nzmKTw3SuBPHBpVN/E4DHgRf6FG4Y7fXcalqqpWg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cGcPGpQGEdMdNjlO+SgO9wGt++XZqOj5SOMkEwQYBPbmuJTuzBPa8iWbeOqeELXazpxnfoV4GqYcL11GWfpp8K3AZdEh/LiiCQZbPe0tAavcueeHAWMlz5mbvdg+yCCTzPL/atDJ6YakjD+5j2Gb0QCE1QdMm8NDcVDAGSPNsxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me; spf=pass smtp.mailfrom=maquefel.me; dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b=B9hZXO59; arc=none smtp.client-ip=178.154.239.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maquefel.me
Received: from mail-nwsmtp-smtp-production-main-78.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-78.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:5a2f:0:640:98f8:0])
	by forward502d.mail.yandex.net (Yandex) with ESMTPS id 6048360DC6;
	Mon,  9 Sep 2024 13:41:40 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-78.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id cferTFn7N4Y0-FFS44uN7;
	Mon, 09 Sep 2024 13:41:39 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
	t=1725878499; bh=bt2nzmKTw3SuBPHBpVN/E4DHgRf6FG4Y7fXcalqqpWg=;
	h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
	b=B9hZXO59lMNzLz4fYwFuocpCfY8Xcb8XUrloPIYSob1NpsZXaBy05A9lOkutPfFtP
	 HEROvknUEqgO2X2GCv9+D73K79qtJKt/PCgPy/hgRqEf1peClNj2Bjk6EQ1Yz4Pv0w
	 EVJ6bLvcdvII5nWwJ9APJmie8wVuEMeskS1wGpp4=
Authentication-Results: mail-nwsmtp-smtp-production-main-78.myt.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <5f2d72241de689b60c016808b274a56ffa6d5c0d.camel@maquefel.me>
Subject: Re: [PATCH v12 13/38] pwm: ep93xx: add DT support for Cirrus EP93xx
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>, 
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 09 Sep 2024 13:41:39 +0300
In-Reply-To: <Zt7N56YRS9u_8zwm@smile.fi.intel.com>
References: <20240909-ep93xx-v12-0-e86ab2423d4b@maquefel.me>
	 <20240909-ep93xx-v12-13-e86ab2423d4b@maquefel.me>
	 <Zt7N56YRS9u_8zwm@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-09-09 at 13:28 +0300, Andy Shevchenko wrote:
> On Mon, Sep 09, 2024 at 11:10:38AM +0300, Nikita Shubin via B4 Relay
> wrote:
> > From: Nikita Shubin <nikita.shubin@maquefel.me>
> >=20
> > Add OF ID match table.
> >=20
> > Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> > Reviewed-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>=20
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>=20
> If you need to send a v13, drop one of the above.
>=20

Sorry Andy, dropped it from my branch.

