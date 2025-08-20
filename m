Return-Path: <linux-pwm+bounces-7109-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E73A2B2D49C
	for <lists+linux-pwm@lfdr.de>; Wed, 20 Aug 2025 09:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54FE0586DA3
	for <lists+linux-pwm@lfdr.de>; Wed, 20 Aug 2025 07:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C93F2D29D0;
	Wed, 20 Aug 2025 07:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="hGXLSCQA"
X-Original-To: linux-pwm@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7915E2D375D;
	Wed, 20 Aug 2025 07:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755674070; cv=none; b=DUlHN+yDAc1nKU7xlBKQ5Ks+2m1qfDo9bMuj5RU1jJ43W7u7wz3RJJUuLMJ4kBo3rbw00IpYbIrCqrLWOQ6FLWbEAPe7YkFUQplVIrcPsjHdz23rNVFEKNiebP78E80BUyGhQ6p4E4PT0lyMCtNkTuXwUkccw+SzWARfSVtyzeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755674070; c=relaxed/simple;
	bh=tV3BgH7JD7Uri/XOLF06iSV2q2nhQTdtZfr0viTJhjE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MK0yZDm/JErgbPT5ik1au0guEO7zgJFk/xuOEPhrDu7tLywVXcJyKsv44j80TOkU9iSWmDUyXTNGFG0AqvslK2ewWVIslaIyIkGO3DuslBqbFt4ReRoR5g6uk3ZAb2HiRYdpEG42ALLSHcg9j1QgYNo6CSKi8bNz/Wsx/5ofxPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=hGXLSCQA; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1755674061;
	bh=h9cQ6nqM4f0ZcfhUClQ3XA7xlJBmCQtUEi7lJZWPs+Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=hGXLSCQAIWgP6Uxicw2kQzQKqoLXwDK2DpNikJF+6wgUZ2Dm8slctHoq4Mb7ndz5C
	 Gfk05YE8wcxW/cCdJTwl5SxYuCyRbe59s/2teJIj2O+99FiFhe0CFYY5ZpyZ0bAtji
	 oAW6z95Q4SVWgu4CsK9ye+DB2y+aq5Rs4s3QXx6o=
Received: from [127.0.0.1] (2607-8700-5500-e873-0000-0000-0000-1001.16clouds.com [IPv6:2607:8700:5500:e873::1001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1))
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 89C5F66E61;
	Wed, 20 Aug 2025 03:14:17 -0400 (EDT)
Message-ID: <1f0cad5f8fd36ea72e54d642f6866334a61b808e.camel@xry111.site>
Subject: Re: [PATCH] pwm: loongson: Fix LOONGSON_PWM_FREQ_DEFAULT
From: Xi Ruoyao <xry111@xry111.site>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>, Binbin Zhou
	 <zhoubb.aaron@gmail.com>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Juxin Gao <gaojuxin@loongson.cn>, 
 Huacai Chen <chenhuacai@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
 linux-pwm@vger.kernel.org, 	loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
Date: Wed, 20 Aug 2025 15:14:15 +0800
In-Reply-To: <bssxtcjtp4pnt3cymcrqnuwdzgdhwk5udnqwsh3xvmo2kkd567@5ovlk34bb4or>
References: <20250816104904.4779-2-xry111@xry111.site>
	 <n5kdswq7oduruqiruyup4rcdwrs76tlinz26swotzeqklterey@off5cbv5i4e5>
	 <CAMpQs4LqEWSoMUZpcbyknuEvf48FMMgra+Jffk0AXvTiZYjANg@mail.gmail.com>
	 <bssxtcjtp4pnt3cymcrqnuwdzgdhwk5udnqwsh3xvmo2kkd567@5ovlk34bb4or>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-08-20 at 08:36 +0200, Uwe Kleine-K=C3=B6nig wrote:
> Hi Binbin,
>=20
> On Mon, Aug 18, 2025 at 05:38:34PM +0800, Binbin Zhou wrote:
> > On Sun, Aug 17, 2025 at 6:59=E2=80=AFPM Uwe Kleine-K=C3=B6nig <ukleinek=
@kernel.org> wrote:
> > >=20
> > > Hello,
> > >=20
> > > [adding Juxin Gao to Cc:]
> > >=20
> > > On Sat, Aug 16, 2025 at 06:49:05PM +0800, Xi Ruoyao wrote:
> > > > Per the 7A1000 and 7A2000 user manual, the clock frequency of their
> > > > PWM controllers is 50 MHz, not 50 kHz.
> > > >=20
> > > > Fixes: 2b62c89448dd ("pwm: Add Loongson PWM controller support")
> >=20
> > I have confirmed once again that this was indeed my mistake. Thank you =
again!
> >=20
> > Reviewed-by: Binbin Zhou <zhoubinbin@loongson.cn>
>=20
> Thanks for your confirmation.=20
>=20
> My gut feeling is that this isn't very urgent and taking this as merge
> window material for 6.18-rc1 is fine. I still applied it to
> https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git=C2=A0p=
wm/fixes
> and will send it along if something more urgent pops up. Please tell me
> if you think I should bother Linus with it and get it into 6.17.

Just FYI: the issue was detected when I debugged a screen flickering
with a downstream backlight control driver.  As this backlight control
driver is not upstream yet anyway I don't see an emergency myself.


--=20
Xi Ruoyao <xry111@xry111.site>

