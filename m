Return-Path: <linux-pwm+bounces-6852-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F360B09CED
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Jul 2025 09:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 766683AE7C3
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Jul 2025 07:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26AE28150F;
	Fri, 18 Jul 2025 07:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=growora.pl header.i=@growora.pl header.b="dXnMLNcw"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail.growora.pl (mail.growora.pl [51.254.119.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D162798FE
	for <linux-pwm@vger.kernel.org>; Fri, 18 Jul 2025 07:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.254.119.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752824770; cv=none; b=om2rFgJkRXvuswL9PrkhFJSP867Z0EwPnlHpGaWM5iKNU3Iw+8Gr3cq/b2Vjtdzb9UrTYloYEbbjW04JER2RLgwAGmsm4NVXx74swG54e2lRZObTZOZjVGnu3ncfrEZmDWS1F/X+O0NNSjY9dqvcvYHFb8Om01RqVszI47HYW4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752824770; c=relaxed/simple;
	bh=RSy3akR1+Z0TK1MqUcCTAhuNDshd4oA9g7Cu4aFIABY=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=idxeXgMzPpD8i6K/naAD35RUl/fNsSRJzD4H4JXozdy801r1ivdPVUxUkiXTTgefdadSQ4XNCCV6zrgVdliK5kiu+Tlfl0CqwOHBaxLhl00mQnxXxMdI/9nni+QtNSPZjRg0g6BU70fCbaHpUceoPTeFs+7oOg//czuNW7UgL3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=growora.pl; spf=pass smtp.mailfrom=growora.pl; dkim=pass (2048-bit key) header.d=growora.pl header.i=@growora.pl header.b=dXnMLNcw; arc=none smtp.client-ip=51.254.119.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=growora.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=growora.pl
Received: by mail.growora.pl (Postfix, from userid 1002)
	id 4DA8D24688; Fri, 18 Jul 2025 09:41:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=growora.pl; s=mail;
	t=1752824541; bh=RSy3akR1+Z0TK1MqUcCTAhuNDshd4oA9g7Cu4aFIABY=;
	h=Date:From:To:Subject:From;
	b=dXnMLNcwMBSo/sE00XXNKmV2/Vj4VntvnKlQe27gWEO9XH/4uWMT/T95C9DpbNADp
	 XKRT2wMjf4yo4ojRrsfvey9Hhn+5Y2Rj6NdLop9R680zRRm5sSOK2ABOGhAJjeO8gP
	 ReoAKq9IZHyJJ2V+U6CCVs9aWT5ikSNe8xa1+P4+2wfHua3apVePovXQxK9LaBcMMw
	 loK2jxpCU1K8TVdFmojQ7Yf1VzYR8Om9udlDgNMnKvZCq2OmhYukM/NbKWEzAK6aj/
	 bYT7yQbqgGyda2ylTHgWZcd5jxXjKYKZ4uo44wdCl5qt6h8Z6sr9aNgA5KyKrs3ZPP
	 YKaI392EOYEng==
Received: by mail.growora.pl for <linux-pwm@vger.kernel.org>; Fri, 18 Jul 2025 07:40:59 GMT
Message-ID: <20250718084500-0.1.kp.29a03.0.fedeztnu9f@growora.pl>
Date: Fri, 18 Jul 2025 07:40:59 GMT
From: "Mateusz Hopczak" <mateusz.hopczak@growora.pl>
To: <linux-pwm@vger.kernel.org>
Subject: Wsparcie programistyczne - termin spotkania 
X-Mailer: mail.growora.pl
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Szanowni Pa=C5=84stwo,

czy w Pa=C5=84stwa firmie rozwa=C5=BCaj=C4=85 Pa=C5=84stwo rozw=C3=B3j no=
wego oprogramowania lub potrzebuj=C4=85 zaufanego zespo=C5=82u, kt=C3=B3r=
y przejmie odpowiedzialno=C5=9B=C4=87 za stron=C4=99 technologiczn=C4=85 =
projektu?

Jeste=C5=9Bmy butikowym software housem z 20-osobowym zespo=C5=82em in=C5=
=BCynier=C3=B3w. Specjalizujemy si=C4=99 w projektach high-tech i deeptec=
h =E2=80=93 od zaawansowanych system=C3=B3w AI/ML, przez blockchain i IoT=
, a=C5=BC po aplikacje mobilne, webowe i symulacyjne (m.in. Unreal Engine=
).

Wspieramy firmy technologiczne oraz startupy na r=C3=B3=C5=BCnych etapach=
: od koncepcji, przez development, po skalowanie i optymalizacj=C4=99. Dz=
ia=C5=82amy elastycznie =E2=80=93 jako partnerzy, podwykonawcy lub ventur=
e builderzy.

Je=C5=9Bli szukaj=C4=85 Pa=C5=84stwo zespo=C5=82u, kt=C3=B3ry rozumie z=C5=
=82o=C5=BCono=C5=9B=C4=87 projekt=C3=B3w i wnosi realn=C4=85 warto=C5=9B=C4=
=87 technologiczn=C4=85 =E2=80=93 ch=C4=99tnie porozmawiamy.

Czy mogliby=C5=9Bmy um=C3=B3wi=C4=87 si=C4=99 na kr=C3=B3tk=C4=85 rozmow=C4=
=99, by sprawdzi=C4=87 potencja=C5=82 wsp=C3=B3=C5=82pracy?


Z pozdrowieniami
Mateusz Hopczak

