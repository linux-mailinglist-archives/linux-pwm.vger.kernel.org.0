Return-Path: <linux-pwm+bounces-7291-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C316B5292E
	for <lists+linux-pwm@lfdr.de>; Thu, 11 Sep 2025 08:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E900D562A26
	for <lists+linux-pwm@lfdr.de>; Thu, 11 Sep 2025 06:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A70B263892;
	Thu, 11 Sep 2025 06:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="aKGilMM0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31434225768;
	Thu, 11 Sep 2025 06:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757573013; cv=none; b=Ok1IIAUykd7WiuA6AOBYrGbDOJzEMLZdS/x1Xo51wt6aqwcADxMwpRYf/SrkRvYiBUnihWchpmPLEEa4OBAQjExWg86ptsZleftrVGiVPOcjkiWgIEa8o3vVGaUMq8SVG62zxIKqGMB2hiBUEF/MF0cc/Xe125+wm6nIXoOgot8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757573013; c=relaxed/simple;
	bh=kJwYC7m9zxvw8t0Wh8werWniscpbbGs2n2AbxCagyyM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IBPo7G0jLYtjWT9TIZf9tkm75yejiBxmmeFAvX5nJBuzKJlkcNs8jlDQCGiAnY91dD3Azk8bjUG/p2pqSCq8CMsYV4kdsD/AAAc7QxCwI5/thUs2G+9QQa18RF6VWFbCb3hXLfooi3Rb+YjJZIOmzLnunmAk5yQyoSqYvtNmc1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=aKGilMM0; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=SH8grCcQsI/A0Zb/ejlOuThuyf2HO3NNcGzlLC9g4yY=; b=aKGilMM0327KDVFXFHWUmWBs/T
	D0Dec7HW0mGxsGX3W1rgFhbQcUHbox2iR9coWBN+C/3XIcIJM4VLQFm+4/NXxhoF9ZBLalCRojyG4
	5RYY6BeShVptaKVqVqHGOo1SV8E9LqTdjpP0w4XlifY3EisPsloU0uv12oJw2q5beTv5oqVupakfE
	F1tXQiOfUTXrMYryalZDCREjsE1HBGxJ5QQtgDeLGuH5YULlkipMck/0rSa2YWLsjeUlOOSyq+pSx
	bkFSPRcd206PHwn8Z6okl8fUmqU0o815gvchRSMO7PVEN7Qb0J1dI/5GXI1dyWOHJmpyQ7P/i0g4k
	flV+8nMw==;
Date: Thu, 11 Sep 2025 08:43:23 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jihed Chaibi <jihed.chaibi.dev@gmail.com>, lee@kernel.org,
 krzk+dt@kernel.org, tony@atomide.com, robh@kernel.org, conor+dt@kernel.org,
 ukleinek@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-omap@vger.kernel.org
Subject: Re: [PATCH v7 0/3] dt-bindings: mfd: twl: Consolidate and fix TI
 TWL family bindings
Message-ID: <20250911084323.357caec2@akair>
In-Reply-To: <20250911-dainty-penguin-of-fragrance-9b4cef@kuoka>
References: <20250910160704.115565-1-jihed.chaibi.dev@gmail.com>
	<20250911-dainty-penguin-of-fragrance-9b4cef@kuoka>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am Thu, 11 Sep 2025 08:35:32 +0200
schrieb Krzysztof Kozlowski <krzk@kernel.org>:

> On Wed, Sep 10, 2025 at 06:07:01PM +0200, Jihed Chaibi wrote:
> > This version addresses a final piece of feedback from Andreas to make
> > the twl4030/twl6030-specific child nodes (audio, usb, keypad etc.)
> > conditional by moving them out of the common block, which now only
> > contains common properties (rtc, charger, pwm, pwmled..) ensuring
> > the schema is fully accurate.
> >=20
> > The complete dtbs_check for this binding is clean except for two
> > warnings originating from pre-existing bugs in the OMAP DTS files,
> > for which fixes have already been submitted separately [1][2].
> >=20
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Acked-by: Uwe Kleine-K=C3=B6nig <ukleinek@kernel.org>
> >=20
> > ---
> > Changes in v7:
> >   - (1/3): Moved twl4030/twl6030-specific child node definitions (audio,
> >     usb etc.) into the conditional 'if/then' block to improve schema
> >     accuracy. =20
>=20
> Who asked for this? It's wrong code.
>=20
maybe I was not clear there. That was not was I meant. As far as I
understand, the correct pattern is to define things outside of the
if/then block and
then disable it with property-name: false in the if/then block
Example: Handling of regulator-initial-mode property.

Sorry, for the confusion.

Regards,
Andreas

