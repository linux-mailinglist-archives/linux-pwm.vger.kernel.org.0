Return-Path: <linux-pwm+bounces-7642-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB9FC6D939
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Nov 2025 10:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 89F352D69C
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Nov 2025 09:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B29F33375E;
	Wed, 19 Nov 2025 09:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=businero.com header.i=@businero.com header.b="FTJ9X9ms"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail.businero.com (mail.businero.com [162.19.67.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BE8334361
	for <linux-pwm@vger.kernel.org>; Wed, 19 Nov 2025 09:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.19.67.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763543098; cv=none; b=KXFxrcLEXDVXL6dYbHI9SB0MKowbvzl8Qu07hJvk6OnpnQJVkN6okFGDEB1s4hicKSsc4GCWXU4WeJq2YjdWH1deYFpphL0TrHPbQCPpPGf7p1mXKRpAtvLbkIH4FPNBEHcFxdgX8GA1G+2gKvhOrvy/cDetjMkuG0jsUC1+jjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763543098; c=relaxed/simple;
	bh=leFBUk45hKySV1sOBifzyACe7LDxt6sMLW47f3iaKCI=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=Do5TBoaD9mb93AS6jVtG005F9HYy2fbhDovPacS6qAKPKiDrqWjwi2JJK1g1U2+msAo/Gui58kBiV0OQPArK4BrI9dTCtwz8gRZcqMEUo0F7fTTrIhXmg09lbyZwMLTmCdAGQXydf+StH1nq/iAcxhzA7YyqAubylcA2RZa50Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=businero.com; spf=pass smtp.mailfrom=businero.com; dkim=pass (2048-bit key) header.d=businero.com header.i=@businero.com header.b=FTJ9X9ms; arc=none smtp.client-ip=162.19.67.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=businero.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=businero.com
Received: by mail.businero.com (Postfix, from userid 1002)
	id 8AB22226F8; Wed, 19 Nov 2025 09:56:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=businero.com; s=mail;
	t=1763542573; bh=leFBUk45hKySV1sOBifzyACe7LDxt6sMLW47f3iaKCI=;
	h=Date:From:To:Subject:From;
	b=FTJ9X9mstS2LE2jUExezFJlRwGYsCp/Y2Z6gMsaCAiRQhQEpUL6U2pwc2TXAvCZMd
	 o0aRuvQsETIaO4I5sUGrK9dSoAW10hA0FLFWvD7N44EGG0CQjQ9A7VxdDdJ3WhaANI
	 dadd4sBBZ+tSF1Qb3DPRb6iKNK0qVRQHpfy8HNXHNW8YpnZ+4QZImNQLi7IiM0t3wy
	 zJ9bHYytpcfL78xBWbARGB014lX9Za8pMoYJEwNLs9DymAyfyZuUSy7WfLxw46Fjk8
	 9l6iHP9PLFO8a12Rrezg+iiryfvhgReryuyrCW6U8k7D/i9/e4jZhsRweV/w/WpcNh
	 y95sKjCitkYew==
Received: by mail.businero.com for <linux-pwm@vger.kernel.org>; Wed, 19 Nov 2025 08:56:05 GMT
Message-ID: <20251119084352-0.1.cf.1e3fh.0.8fe94tvng6@businero.com>
Date: Wed, 19 Nov 2025 08:56:05 GMT
From: "Sofia Laine" <sofia.laine@businero.com>
To: <linux-pwm@vger.kernel.org>
Subject: Saumattomat lattiat
X-Mailer: mail.businero.com
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hyv=C3=A4t naiset ja herrat,

maailman johtavana hartsilattioiden valmistajana ja asentajana tarjoamme =
ratkaisuja, jotka kest=C3=A4v=C3=A4t hankausta, kemikaaleja, kosteutta ja=
 =C3=A4killisi=C3=A4 l=C3=A4mp=C3=B6tilan muutoksia.

- Turvallisuus ja kest=C3=A4vyys =E2=80=93 ISO-, HACCP-, PZH-sertifikaati=
t
- Ei seisokkeja - asennus 24/7, my=C3=B6s viikonloppuisin ja pyh=C3=A4p=C3=
=A4ivin=C3=A4
- Ekologiset ratkaisut - alhaiset p=C3=A4=C3=A4st=C3=B6t, helppo huoltaa
- T=C3=A4ysi tuki =E2=80=93 suunnittelusta asennukseen ja huoltoon

Haluatko hy=C3=B6dynt=C3=A4=C3=A4 ilmaista teknist=C3=A4 auditointia, jok=
a auttaa sinua valitsemaan laitoksellesi parhaan ratkaisun?


Yst=C3=A4v=C3=A4llisin terveisin
Sofia Laine

