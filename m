Return-Path: <linux-pwm+bounces-2736-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2858592B0AE
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Jul 2024 08:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C588E1F2506A
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Jul 2024 06:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48EC13D516;
	Tue,  9 Jul 2024 06:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0T8OLOIJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8A413C3CC
	for <linux-pwm@vger.kernel.org>; Tue,  9 Jul 2024 06:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720508076; cv=none; b=qm3dRPaqxgx871/Vklmzl0MGg7piKI9GMY3NtO7c1RkwS9UyZutJtpXv7s8E+xVqE0ATWiJPRNrZTpq97z/P9kddO97hl7GQwGXNOI7pEndFz7yFbSsO0NIEs5lvFb80xdHzCNgfAG+wTxNcd68infCltE9Qev8kJ1b1B4k3uh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720508076; c=relaxed/simple;
	bh=rIZEIiPZR8PjUsYKnfS0bDTgQruNjA3bTRgWWcdleks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CMpU4DwIU5oZR1n+KPAAfAzITqOOST6Vt1omZsTCFBsEQE2aB8lp0SY/3Q753JFMW7qzVHqoZ5u+n75kvWS9FILmPakT8TBxdYvmjQ6F2ldTPWy5lw8TCy/WWtEq9daibzv1gpwQN4nwpO3KvpO0ru3t8Vyq4I4LcCi/77/8mS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0T8OLOIJ; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-58c2e5e8649so8564216a12.1
        for <linux-pwm@vger.kernel.org>; Mon, 08 Jul 2024 23:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720508073; x=1721112873; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rIZEIiPZR8PjUsYKnfS0bDTgQruNjA3bTRgWWcdleks=;
        b=0T8OLOIJD1XAwRKy+aNUltYNjOVVxDVGl5i8W6Ox68sJdHim2ZrWyEj3Cx6u+fSard
         VWVoG5z02ZDLg0j4IDUKyhGrZcdkJuAcyyTMsMyeGEelf9mwCqLrDSaPI6jc9LeUII3o
         Vo1n07UrcsVuX+YMcvKeOvbhMJ9GdnZejYZthY6bxETJrCVJsoCgqhI2ZTBBvwbNAfeb
         ABc6xryMDC0Ri8DnxvnLEhrjGF++C9T54Uabf22giGRNmMT6yl949BUwV1YKBgrzjbag
         tVbf8PX5OhDSMFv67a5sTyZ8SE0wT2T5eLuGbQ4gFkfdGWdLRf/gluKnANHi15tpvwBz
         LdPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720508073; x=1721112873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rIZEIiPZR8PjUsYKnfS0bDTgQruNjA3bTRgWWcdleks=;
        b=jBogPocvQvkd2NlwCGGBIlZOnpJJQ6RmvuTyw5AJZK4WejpvmxiIeg9unjCnLC3LuX
         L6uyfPN0WqreuhSMTPTSp4ASlkUJPLzYz20SqBmL3i0bEtQL5nK72SHtYbWRvsH4/0QP
         FWCtPk0Ya7O138h1rT1BVro+sT+8i2D4/G02TU5NhMvU/pieLDjdwAjuym+7I9OcNbnG
         hLi3ZkdMGhfsz75ax7yUyxPPbhq5jghgDKFA5KtCXpk+l3JKszE4wciSYFO6mpafm0UD
         oDMJTHQBt3lkwP5cOrVeODrsoCPTu3kQY/+IFBN0hnykjWEKeRCt+RWA0ypwGqOlPRNB
         P2gA==
X-Gm-Message-State: AOJu0YxYLIZ3Awvc3yl65J61MCdGk280041kXTmHj+dRkltkIfP2lKBy
	ncKOOokA23KrmW2F0Oa1KjXJQ3ZrikrnNZzez54W6krpvyHClRPfnlZTH1a9qDjdy1IfB/cdW+3
	W
X-Google-Smtp-Source: AGHT+IGwlKmGrMdFOnjAKchORxMJC1zLzVMahY0rbUUEDJMua3Vkl2zKW51j3oKcjCmefGMmIvJryA==
X-Received: by 2002:a50:fa97:0:b0:58b:4a7:2a04 with SMTP id 4fb4d7f45d1cf-594de604d45mr902106a12.20.1720508072979;
        Mon, 08 Jul 2024 23:54:32 -0700 (PDT)
Received: from localhost (p50915e7b.dip0.t-ipconnect.de. [80.145.94.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bbe2cf93sm706724a12.33.2024.07.08.23.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 23:54:32 -0700 (PDT)
Date: Tue, 9 Jul 2024 08:54:31 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Trevor Gamblin <tgamblin@baylibre.com>
Cc: linux-pwm@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] pwm: Add tracing for waveform callbacks
Message-ID: <yz57gqlyqk2f3r6rtwun3yplns2rxwfaqdgqey5ipmqmdqgrcu@koclgglkjtwq>
References: <cover.1720435656.git.u.kleine-koenig@baylibre.com>
 <7f7ce46efc76e02a472ed52ab1fc06c3575a14e8.1720435656.git.u.kleine-koenig@baylibre.com>
 <c12fe2f2-404b-454a-8474-0020a4aaafb6@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tcjng6xahjawfwjm"
Content-Disposition: inline
In-Reply-To: <c12fe2f2-404b-454a-8474-0020a4aaafb6@baylibre.com>


--tcjng6xahjawfwjm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 08, 2024 at 02:14:09PM -0400, Trevor Gamblin wrote:
> Missing a sign-off?

Yes, and a commit log.

Thanks for your review!

Best regards
Uwe

--tcjng6xahjawfwjm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmaM3qUACgkQj4D7WH0S
/k7jZggAi0uG9uwtF+gXHub7qdnBzopWLzdItTN+jviBIRaKZf1PiCnsFn5weriY
VosJwlbLry9/TUtf3lqf2xHxo03IjrXxgzXUT+bMG9Kk91tbCDFsHhXwaCxEvbPF
oAspz+V7PgEIN4o8zKQu4U3GvUUETWjGriDR9FtgBl2Pna04/zcg+GkGVJ11GbjW
K1noG/Hsx71SASB6pnb2HxCUHd6L4QkctE8rFF84kc7CrgQQOEnjxAHw4ibQ4OU8
44OCr/2J4dfhGO39bpZ//nuHeCg0DC6w6ps+M3cwh2JgUOSBurKuUrwh7wrF2JH8
dWAgA6BoUj7lzjP6PInoMrfHpelCmQ==
=fWj3
-----END PGP SIGNATURE-----

--tcjng6xahjawfwjm--

