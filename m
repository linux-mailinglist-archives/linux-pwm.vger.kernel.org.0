Return-Path: <linux-pwm+bounces-6689-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F20B3AF0DA3
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Jul 2025 10:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D6F61C24656
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Jul 2025 08:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B03236454;
	Wed,  2 Jul 2025 08:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=growora.pl header.i=@growora.pl header.b="PaF422Re"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail.growora.pl (mail.growora.pl [51.254.119.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A24B237194
	for <linux-pwm@vger.kernel.org>; Wed,  2 Jul 2025 08:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.254.119.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751444109; cv=none; b=QWUjpsgCoDen7iO2Jr8nhfYo52X7hOKB63975M2bsoRgc+OM2A1fJH7QNCjJmgdIvQmy0P8hWQnNEIQcFEqwQHr8MrM7+jfc2PEY4ZmAOHzl+rxpWmZjHKF1SSFmLZvXjc/welMC7aNCKUL7lJj0/cJD2wA6UlOUCWWuSyUpZwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751444109; c=relaxed/simple;
	bh=RSy3akR1+Z0TK1MqUcCTAhuNDshd4oA9g7Cu4aFIABY=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=H4QACnHHF9GDOhO+9alQ1qyh4ik7BPWTOVG+UF5eTOwhnJbBLXIgt0miyYyKDJ6lJWpGHRy5sIg9v8l42ON+qpyMrvBbih7bdR65pOLSu8MDmPvu6/Mi8FoGQ+4A77AuZqURRpdk7Q3JkP0guBPS/fanMr8xT9mwX6PJMsidUrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=growora.pl; spf=pass smtp.mailfrom=growora.pl; dkim=pass (2048-bit key) header.d=growora.pl header.i=@growora.pl header.b=PaF422Re; arc=none smtp.client-ip=51.254.119.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=growora.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=growora.pl
Received: by mail.growora.pl (Postfix, from userid 1002)
	id 1052824B0C; Wed,  2 Jul 2025 10:10:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=growora.pl; s=mail;
	t=1751443877; bh=RSy3akR1+Z0TK1MqUcCTAhuNDshd4oA9g7Cu4aFIABY=;
	h=Date:From:To:Subject:From;
	b=PaF422ReL9JpHbYGDMxnHFqz8FwB4tiXZ6AEfGijUP9brPCDFxYO/e9Tgunom3aoN
	 a7e3Rnnzdvm1cGlcf1F7BJfOI9eWzaCS+bA2w05trkj3qUR1axY0233F1FmKdZGvZh
	 LDpDFyh60gohyRC8Zvos7XNy5qdvCYrK5oBqu0J6lfSHfJibjOmYcnhn/kZZc0zNl9
	 WXf9swlVz719B67339S6bMbOsmLt5AoBeh98ZvS4sExnF8EFsESsWSTTwxQVXPjOWK
	 iR5LXNT1MdGYYpUAsRqXepExeL0LUeQ+XGgyL7P+ylHtL7k0XAtnvzjbk1640T8bMP
	 lNQ5k+6rAcX0Q==
Received: by mail.growora.pl for <linux-pwm@vger.kernel.org>; Wed,  2 Jul 2025 08:10:24 GMT
Message-ID: <20250702084500-0.1.kd.23mwq.0.57yiuab3st@growora.pl>
Date: Wed,  2 Jul 2025 08:10:24 GMT
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

