Return-Path: <linux-pwm+bounces-7337-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CF2B8E84D
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Sep 2025 00:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72904189C9AC
	for <lists+linux-pwm@lfdr.de>; Sun, 21 Sep 2025 22:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF7726F299;
	Sun, 21 Sep 2025 22:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="a+siZ4Yo"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEC312F5A5;
	Sun, 21 Sep 2025 22:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758492773; cv=none; b=QkQNijNqXNfr9DcNrUb8r3kbgndkSBjFFp9jm4YlN1QSVQMXtomgFFlX6MMJSdCZxvGkJs0B50D7nSuHNJNT4s/+xzS86OorgpmOOhmtsp3RWvq9Yo0BsjlRnwKFyISve3CPE/FbqIcCTZOebaGsDrxNo4McxPwneUmMimGX4Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758492773; c=relaxed/simple;
	bh=CaMFqxK4P+edoKm7IoaR9E43eWXX4ELaNvNg+hxBplg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eFqsbDzCSRiwBNqXLLSgRB0LfKl6QlSnkAA4avv98huYNuaANZ0m/ogaF6SeqVcQHC9YzSvainB++ET4qqr8ZtvRm7cYIVQaejs8yGbzhb41vv9lC9fENMnLHAfC2B3LhutrkvaB/5/P1I6d32uzUqISgCR1o0dBkK/3eLIwGTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=a+siZ4Yo; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=CaMFqxK4P+edoKm7IoaR9E43eWXX4ELaNvNg+hxBplg=; b=a+siZ4Yoga+wMKE2p+IAPnLMXy
	w3uyqhmJbaa7IH0Aw7rm13Ms+ran2tqxzowavsRJwrhGJDdqhGM2onaxSt7/YPGDIsIn5QSyfz2aB
	pTPB3OeZKAjAVZ/iutAUT6LYQylpToTcrtBdbAdwD2Sv10+wZe3vPNMsEbEeGjfHfjZ7yaLM+PvbI
	TQvDRMfYJ7DjlXfDHW07Jhdjrm1Y4BnIe9FJ/T9RWLmXEB2tR2jexFaUKY2zpIM4OehdH41quGIq+
	sirIOIRiqW2YtSXAaIDoQuFB8iIg3ky0mKg4ZpCzmQrra+/B3mdmbyDwPrwqEs+aWMA0QYRMM9+b2
	Idy/K+gQ==;
Date: Mon, 22 Sep 2025 00:12:44 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
Cc: lee@kernel.org, krzk+dt@kernel.org, tony@atomide.com, robh@kernel.org,
 conor+dt@kernel.org, ukleinek@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-omap@vger.kernel.org
Subject: Re: [PATCH v8 1/3] dt-bindings: mfd: twl: Add missing sub-nodes for
 TWL4030 & TWL603x
Message-ID: <20250922001244.298cb24a@kemnade.info>
In-Reply-To: <20250914192516.164629-2-jihed.chaibi.dev@gmail.com>
References: <20250914192516.164629-1-jihed.chaibi.dev@gmail.com>
 <20250914192516.164629-2-jihed.chaibi.dev@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 14 Sep 2025 21:25:14 +0200
Jihed Chaibi <jihed.chaibi.dev@gmail.com> wrote:

> Update the main TI TWL-family binding to be self-contained and to fix
> pre-existing validation errors.
>=20
> To ensure future patches are bisectable, child nodes whose bindings
> are in other patches (audio, keypad, usb, etc.) are now defined using
> a flexible 'additionalProperties: true' pattern. This removes hard
> dependencies between the MFD and subsystem bindings.
>=20
> The complete dtbs_check for this binding is clean except for two
> warnings originating from pre-existing bugs in the OMAP DTS files,
> for which fixes have already been submitted separately [1][2].
>=20
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Uwe Kleine-K=C3=B6nig <ukleinek@kernel.org>
> Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
>=20
Reviewed-by: Andreas Kemnade <andreas@kemnade.info>

