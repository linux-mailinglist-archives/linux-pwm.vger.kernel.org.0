Return-Path: <linux-pwm+bounces-7701-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F092DC8714E
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Nov 2025 21:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 937CA3AB082
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Nov 2025 20:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5A62DC33F;
	Tue, 25 Nov 2025 20:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UcbwhGgu"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C702DE6FB
	for <linux-pwm@vger.kernel.org>; Tue, 25 Nov 2025 20:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764103167; cv=none; b=Ngn70/bJ0hXURg3GNW2TJHgFtlMvSSQvYpa708eg1ld9Qy6Wv7XK662NCTfDjlwzeveJPd2wFDwMtiCYo88Q8HSdsta2MKGOsamKo2RdMajJemgkOGNLhf7xwlVWOZr4Crn2YygPqgOYRH66dE4MAnwgoKoSNYYPXp0yZ6N9JIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764103167; c=relaxed/simple;
	bh=iUDfjVYPzYpiqM6ZYPz1ZEkDZo55Us4v5tuNI7J7HIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oHTuEsuyyr1wJ1mtbXMKyJ8FhrCyKC8zor3J1BX6PFYpeKNgy6kYItCp1OLaCCJtoCa5YxC8ZQ8+O8hr6cYvO15tVzOS05I1vQ2Pbe6SMYYFtkbnRdWV/OHgv7SV3xlm6Lv65jvdHZ97sbcnGbahN5Or2QFENHgm73hff0KOB7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UcbwhGgu; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b98983baeacso2928495a12.1
        for <linux-pwm@vger.kernel.org>; Tue, 25 Nov 2025 12:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764103165; x=1764707965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iUDfjVYPzYpiqM6ZYPz1ZEkDZo55Us4v5tuNI7J7HIU=;
        b=UcbwhGguZ+WVK5QFrgBBtp+uGCeyUYnXnmLYPuKXb57LxbFWCh22m+GWKafZhKXuCo
         Q+Fx3btMPzTXn2Ooqt6O3Q2sRlGhNrDwmUOpQSBbw6a3164oPdnlbFXQvAWY791lG1UB
         PWIHInXU5ZyoUfm2lDpYeTXwnk2sXbT6oxMjOidAr2qEA1cPZy5naKDRByPLkZ3m1WW/
         +kRJaTVEqerKIG32dr/V52cldc/QWuyxXgwENTAbM4LujhYVneHzqQk5fq6KvslsE49g
         wDXwlxX/GsVsgY3Jt9IA0/vB8kb3Xxe95+tDp6mBwMNnpj4mAyOuDdJnqT/Uc9Cdny7f
         7b5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764103165; x=1764707965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iUDfjVYPzYpiqM6ZYPz1ZEkDZo55Us4v5tuNI7J7HIU=;
        b=wnppIvDOMYtRc9ixWAivyNccuvebXzhIgI9ZA6/K8s3GduCotaZwXEzaiiIUQ2yrAM
         1DwkY7krwqJu83pcSKz9NCKlJd/xY58fYTpAQeNFsd7ZeCO6ggMQFNiFpS3RCZDlcHRM
         Vuw+vi+Z43bqq5CXaBGBtFLKmZF6R4+MJyMa9ydZma2qvRvr5T48MDB4O/K+Crky3fE4
         P/eIEBsOAlS2CrrezH67eW8ecuAk4aJ6+bcG+uIi/k4nTR9eb5O62fG6fHcZnULbOTUU
         NkDlqCU8+Jrq6OFqV+ZeVdzILcAwYQlUydIiYM3XyFw/i7pIXIGXjjNpHv0Rlj6O4723
         dj5A==
X-Forwarded-Encrypted: i=1; AJvYcCUaxP2ebvHMDvpSPihsIStzFfgr3sXwWJsz1Hw8bnry1TKIaALTm2FUSkNOGhLvhg7tlDbvxtexbOs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+czHBcOGDUwbGDFGq8X/g8cEo5JCuUMMjdazGurr+AKSfVCXX
	8MXWgoyar062Yavm9I7XMe0mIS5vF/VFSj1zds09Ps5pfLYs+uHaoqso
X-Gm-Gg: ASbGnctav2l8orJ+M70XuzSYfHgNfRO3MGHgIk34QunSrp5lDZjz+mTixaMwgJ6/bWi
	xEGSIWYuCxQW3htgdyppnyBJQvEcvkD/MtikJgtp5W2btxONU/7sWf20xb75ilsdO99FJ3ObYn/
	5R0YHeHT96inxightp77A1CPD4oGwvFngEXhmVMvGERFQHiVJwxZ2MFsyRli49QtExurs/d98nZ
	lLi+dHa2QrSjzGIwbHMbBtaH5kR4M2Yg8rlP47TV0Z5753G1xYbBa+m0l1w1Ii5xTvJ3pG0SX0E
	mD9Fnn+lqXq66p0461L+D7X4Mg77EwOxR7KD+yN2LA0zPsvnd1lr0/VkKuidyNz4gq4SBl3eptM
	3I/hh7EMV/Nz9noROA30lGLgczg5vCn71eU1vGntZ/VtDRSCM65pWMt5d/Gjk+mvSmpmwYNCtTw
	XkV/5BWFodg4t8qUougMlaskNlF8NBErp0e2+Le9LrlSU=
X-Google-Smtp-Source: AGHT+IGyYnm5EMnNGyvCppc9+ubFH6M/b3GC8V0NGpGA5GnoQRQG+dFIRa5OVSFcqJEcx+nTkGCwsg==
X-Received: by 2002:a05:7301:4290:b0:2a4:3593:dde8 with SMTP id 5a478bee46e88-2a719d7ff4dmr7946082eec.21.1764103165004;
        Tue, 25 Nov 2025 12:39:25 -0800 (PST)
Received: from ParadiseLost.localdomain (lohr.com.br. [177.69.253.233])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a6fc204881sm73145801eec.0.2025.11.25.12.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 12:39:24 -0800 (PST)
From: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
To: ukleinek@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	rafael.v.volkmer@gmail.com
Subject: Re: [PATCH v6 4/6] pwm: tiehrpwm: implement .get_state callback
Date: Tue, 25 Nov 2025 17:39:19 -0300
Message-ID: <20251125203919.1136-1-rafael.v.volkmer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <b2uf4jtvavhnktunabpufq7vyqiqrrwkcf7u6t7ffj3ll2ktmh@4w4myyquf26q>
References: <b2uf4jtvavhnktunabpufq7vyqiqrrwkcf7u6t7ffj3ll2ktmh@4w4myyquf26q>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Uwe,=0D
=0D
ok, I=E2=80=99ll do that then and rework the series to adapt tiehrpwm=0D
directly to the waveform callbacks, dropping the legacy=0D
apply/get_state ones. I=E2=80=99ll try to get to this and have a new=0D
version ready sometime next week.=0D
=0D
Before I respin the whole series, would you mind having a quick=0D
look at patch 5/6 (the one handling already-running channels at probe)?=0D
If that direction looks fine to you, I can fold any comments into it=0D
and then send everything again as a single updated series.=0D
=0D
Best regards,=0D
Rafael V. Volkmer=0D

