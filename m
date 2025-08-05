Return-Path: <linux-pwm+bounces-6977-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38140B1D499
	for <lists+linux-pwm@lfdr.de>; Thu,  7 Aug 2025 11:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D32113B271F
	for <lists+linux-pwm@lfdr.de>; Thu,  7 Aug 2025 09:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A87125F963;
	Thu,  7 Aug 2025 09:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=capitalcraft.pl header.i=@capitalcraft.pl header.b="rOFvvd+i"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail.capitalcraft.pl (mail.capitalcraft.pl [57.129.67.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6601725DD1E
	for <linux-pwm@vger.kernel.org>; Thu,  7 Aug 2025 09:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.129.67.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754558105; cv=none; b=vE53GVUvkz87gS20qZGqPkYToyG/eOHNXmcd8cj2zGKneCXC4NRyL2EU3L447E8lkq55S5yDQcZoPvwFvOGUjdwNEtubvzf5xtZfbci+csisxA2igHjy4Rpb5tVCBMBv6gYxExj+O7vpYazf6refhR2KZkMC3yTrrrZXSTvSv/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754558105; c=relaxed/simple;
	bh=4udjhVtkPvpeQ4By44W9lTmmyaXV2fwWY0xc+9IIdSA=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=XLwOJRup4EQU0nnJrVlk+JdDqpvXu4gsJ/yhNNF6BD0EIkuVitxTwKjKQTo7DiVC9xmpQtpZe6n06gtthx9+Ycy6p0d7QEFNqpKQXvrbK1W0lI9SRiK05tK9CtPzhGqDERo+a6p3q4Ec52Uscqfd5Gupb5O5wGbzj8yL78I4FBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=capitalcraft.pl; spf=pass smtp.mailfrom=capitalcraft.pl; dkim=pass (2048-bit key) header.d=capitalcraft.pl header.i=@capitalcraft.pl header.b=rOFvvd+i; arc=none smtp.client-ip=57.129.67.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=capitalcraft.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=capitalcraft.pl
Received: by mail.capitalcraft.pl (Postfix, from userid 1002)
	id 5CC7226AC4; Tue,  5 Aug 2025 07:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=capitalcraft.pl;
	s=mail; t=1754379756;
	bh=4udjhVtkPvpeQ4By44W9lTmmyaXV2fwWY0xc+9IIdSA=;
	h=Date:From:To:Subject:From;
	b=rOFvvd+iRmEPcPvFdfHimYTBTJ1qn0Fqftc6zV7yZK8Svv/L8Gid4Qoje+vCbAyEd
	 m7UBMBDnww6/eFUjNqsqOzMAUAyevao2IJY/KF1TiffjPlWV638k0EeEqSxOOKZF6T
	 ZsUN/avtq4X+ioqLA4L2z3Y0BeehTf818kTL+7cz0vOmh1XYjVCUcDDMSQDR66rfLg
	 jqsktpJn5XdelLEIhHue1wUjVIkXlBBRDLVVkUDCCXbJNaRX10nSnSO22BXsX1UCDX
	 hk+m8ctd7gsJG63CxT91E8Xy/qGZCE/sPZuL8fsokEw+PooVdejVwfYIDcp9kD0c2d
	 LBrp2fgg+wGNg==
Received: by mail.capitalcraft.pl for <linux-pwm@vger.kernel.org>; Tue,  5 Aug 2025 07:40:40 GMT
Message-ID: <20250805064500-0.1.3u.s5yp.0.oandet90hs@capitalcraft.pl>
Date: Tue,  5 Aug 2025 07:40:40 GMT
From: "Karolina Dylkiewicz" <karolina.dylkiewicz@capitalcraft.pl>
To: <linux-pwm@vger.kernel.org>
Subject: Prawo pracy - zmiany 
X-Mailer: mail.capitalcraft.pl
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Szanowni Pa=C5=84stwo,

obs=C5=82uga prawna w zakresie prawa pracy to nie tylko dba=C5=82o=C5=9B=C4=
=87 o dokumenty i zgodno=C5=9B=C4=87 z przepisami. To przede wszystkim re=
alne wsparcie w codziennym funkcjonowaniu firmy i bezpiecze=C5=84stwo org=
anizacyjne.

W ramach wsp=C3=B3=C5=82pracy oferujemy m.in.:
=E2=80=A2 przygotowywanie i negocjowanie um=C3=B3w oraz kontrakt=C3=B3w,
=E2=80=A2 wsparcie przy zatrudnianiu i legalizacji pracy cudzoziemc=C3=B3=
w,
=E2=80=A2 doradztwo w procesach restrukturyzacyjnych,
=E2=80=A2 przeprowadzanie audyt=C3=B3w prawno-pracowniczych (due diligenc=
e),
=E2=80=A2 reprezentacj=C4=99 w sporach z ZUS oraz pracownikami.

Dzi=C4=99ki wieloletniemu do=C5=9Bwiadczeniu w obs=C5=82udze firm z podob=
nej bran=C5=BCy rozumiemy Pa=C5=84stwa potrzeby i proponujemy rozwi=C4=85=
zania dopasowane do rzeczywistych wyzwa=C5=84 biznesowych.

Z przyjemno=C5=9Bci=C4=85 przedstawi=C4=99 szczeg=C3=B3=C5=82y =E2=80=93 =
czy znajd=C4=85 Pa=C5=84stwo chwil=C4=99 na rozmow=C4=99 lub spotkanie?


Pozdrawiam
Karolina Dylkiewicz

