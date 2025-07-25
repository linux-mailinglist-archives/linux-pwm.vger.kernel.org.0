Return-Path: <linux-pwm+bounces-6882-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0D5B119A5
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Jul 2025 10:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 879EB1CC8161
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Jul 2025 08:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FE92BF005;
	Fri, 25 Jul 2025 08:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=launchiq.pl header.i=@launchiq.pl header.b="P2yswGP2"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail.launchiq.pl (mail.launchiq.pl [57.129.61.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DE02BEC2F
	for <linux-pwm@vger.kernel.org>; Fri, 25 Jul 2025 08:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.129.61.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753431329; cv=none; b=TAwncqX7mmP1qKYlAsBLrALW8L8b+CKp45Nqq6vSrTcMVEmk8ytH8OC1gBaYZ+ga++eWlqGQmHtltJZX5PnO3Pbo1VZOBu6wUHQZic6E8wte235XVOjPrMbKxeTEjUY+plO8j7ngucePXfhCAmmLj/niiUkBBQjRXIpgbTpm02M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753431329; c=relaxed/simple;
	bh=1nV56yiRn7w88ZKIfi9xMzQzsEglWEb9KKVoIWzOJTA=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=UEuBj2wltRQ+k19vN6tgIx+LT7l6LoInL1dRVqRcwKRxCFF6E2SQzf5dm4sFpx2N+wvhT9DTW4rmxgK85aHpMVMsU741FxBdfh5UkJtXJyWp5KyCLvAHBRqCRaOrxj5GAl85YWBCAqArpYUe1gdawbE7tbOjKbT6+Rkd5Lu12wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=launchiq.pl; spf=pass smtp.mailfrom=launchiq.pl; dkim=pass (2048-bit key) header.d=launchiq.pl header.i=@launchiq.pl header.b=P2yswGP2; arc=none smtp.client-ip=57.129.61.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=launchiq.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=launchiq.pl
Received: by mail.launchiq.pl (Postfix, from userid 1002)
	id 7A41B24C70; Fri, 25 Jul 2025 08:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=launchiq.pl; s=mail;
	t=1753431319; bh=1nV56yiRn7w88ZKIfi9xMzQzsEglWEb9KKVoIWzOJTA=;
	h=Date:From:To:Subject:From;
	b=P2yswGP2N2oChdtTw5GPkbGnqn3W7lnEzaH7l13Z5C7e8hZkG7sLGl2aWi9b7B3hn
	 B0pNhNVTBsrE+GkFmKQe6LlQQmUEw6VR2zbMwkUM5w3HJg7Us8yFUZTlP1r4CdKGFj
	 4q+Dn4OeHpP1goy9PnwSjBRhBif5FPegO3kk+lGeQB0IpzoLtYoITZ+sA/SXPgRxLg
	 fjbVJAx3hyAtxk1ZOHri9kEDFwjWTVtB09NIn/kfOarAiq6kR1dOvN01UObp1uzgGa
	 q+NYGsNMrsWMd5bJnQr9ft5y6/fFJkN2GgmVdyqVSwYkaUqExggwhDD27zL3pdQgLC
	 KvgwpTd3fWRcw==
Received: by mail.launchiq.pl for <linux-pwm@vger.kernel.org>; Fri, 25 Jul 2025 08:15:14 GMT
Message-ID: <20250725064500-0.1.3k.afdc.0.ul87xex6rz@launchiq.pl>
Date: Fri, 25 Jul 2025 08:15:14 GMT
From: "Grzegorz Sutor" <grzegorz.sutor@launchiq.pl>
To: <linux-pwm@vger.kernel.org>
Subject: Umowa vPPA - termin spotkania
X-Mailer: mail.launchiq.pl
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dzie=C5=84 dobry,

mamy rozwi=C4=85zanie, kt=C3=B3re pozwala zabezpieczy=C4=87 korzystn=C4=85=
 cen=C4=99 energii na d=C5=82ugie lata =E2=80=94 bez konieczno=C5=9Bci zm=
iany obecnego dostawcy i bez inwestycji w instalacje odnawialne.

Proponujemy wsp=C3=B3=C5=82prac=C4=99 w oparciu o wirtualne umowy PPA (vP=
PA) =E2=80=93 to rozliczany finansowo kontrakt oparty na cenach SPOT, kt=C3=
=B3ry:

=E2=80=A2 stabilizuje koszty energii na 3 do 7 lat,
=E2=80=A2 wspiera realizacj=C4=99 polityki ESG i obni=C5=BCa =C5=9Blad w=C4=
=99glowy,
=E2=80=A2 zapewnia elastyczno=C5=9B=C4=87 zakupow=C4=85 =E2=80=93 cz=C4=99=
=C5=9B=C4=87 energii w sta=C5=82ej cenie z OZE, reszta  =20
  rozliczana na bie=C5=BC=C4=85co,
=E2=80=A2 nie wymaga zmian technicznych ani formalnych po stronie Pa=C5=84=
stwa firmy.

Wsp=C3=B3=C5=82pracujemy z przedsi=C4=99biorstwami zu=C5=BCywaj=C4=85cymi=
 od 3 do 30 GWh rocznie =E2=80=93 g=C5=82=C3=B3wnie z bran=C5=BC takich j=
ak przemys=C5=82, logistyka, handel, automotive, IT i data center.

Ch=C4=99tnie przygotujemy bezp=C5=82atn=C4=85 wycen=C4=99 i indywidualn=C4=
=85 propozycj=C4=99 kontraktu, dostosowan=C4=85 do profilu zu=C5=BCycia e=
nergii w Pa=C5=84stwa firmie.

Je=C5=9Bli temat jest dla Pa=C5=84stwa interesuj=C4=85cy, z przyjemno=C5=9B=
ci=C4=85 przeka=C5=BC=C4=99 wi=C4=99cej informacji lub um=C3=B3wi=C4=99 s=
potkanie z naszym specjalist=C4=85.


Z wyrazami szacunku.
Grzegorz Sutor

