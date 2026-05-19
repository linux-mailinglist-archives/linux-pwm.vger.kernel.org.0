Return-Path: <linux-pwm+bounces-9000-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iALbF8ZHDGoMdAUAu9opvQ
	(envelope-from <linux-pwm+bounces-9000-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 13:21:42 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CC557D74B
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 13:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8AF8E3163FED
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 11:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5654921A3;
	Tue, 19 May 2026 11:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NkzOT8mX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F68E481245
	for <linux-pwm@vger.kernel.org>; Tue, 19 May 2026 11:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779188883; cv=pass; b=FejUdqwVBol69Wo1jTD7uoG8QRs5FkI92p3xVZqv6GxzzMM0l5Mg8bOyCnw1XUxMMAX1MTQvT4vf1eVrmpVRpFqohartT4vMF02BNBR30AhYSBWkD/Yr/2pecppmRqfB0it9IqcymIW050lDblJygmK7x5v2Iq3JvqPxJ5zfsHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779188883; c=relaxed/simple;
	bh=nhTmhA7EtvBhVzOtpkjubbcdCBekT90z9FnlkG56Nt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n++nOzoGyz+X77yBHlW8Ed338LnseXCMAaKHIDD3Ar2Rf/kDWCxGP15hVx78K/3ILEGm13LNC8nGXJGyOyoDcvLwC50rZf7KR8v+UitmbJxadxArYcuNtspn5KSc0QE3Q99H7I2mhiMtvwWHEvr/CBjIY9N+0SVhsKLor/U2qm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NkzOT8mX; arc=pass smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2f13ae64db1so187853eec.3
        for <linux-pwm@vger.kernel.org>; Tue, 19 May 2026 04:08:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779188879; cv=none;
        d=google.com; s=arc-20240605;
        b=QLQN19kgeOy2rINhuhw5nH5hyibBZUpvUiOC0bZasitomcgUp0fpVTaehXx1gOtHPT
         R9/Ckq1ajCu7b6e6ZPLVHZLrKquddpa+SNmkFFs1VZPpD0+QlJ5qthTzsjvzSXT4DUWr
         lQL91gh7w6dVsQU0walnlFHANY7vxef6M4H6zZKIeZuCkBgQSpcilBPpS4eeqY7J2Nyb
         dqDc+3GZpDJ9HHHntO7PIoaUApwcDDwKya1n2uOfpvnu7OfofbLmzc3aLomEvQtR6LNJ
         pUcv9cJbl+pETmpGWZtWVsGl7VZKJoGn/2dDKgj1eBePk4Y+NSaeO5+hoXQkV9xzi/sj
         BFxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nhTmhA7EtvBhVzOtpkjubbcdCBekT90z9FnlkG56Nt4=;
        fh=TPrwWOdSg7suBoGlSsZAnJoTT/NumRXqya7HaE9poU8=;
        b=PtntadWVktg8nzty2Nd9mhpN47v9RRtUIH//i8y8sa5jn6rASlmIXzNcIWwWC+OSZ0
         LbtSnGGGbq3jTEGVARaAEf89kKXcbDheByuH0zKwXLZVeAKMeLEeFc0TuKzMblnrBstb
         thS1cMp8ABvM9xTKM032F7yi0FkdCP7WuXrPVIwcgyV4eNTZ5sPKnMJuFpp3RpqC4vw3
         i6VJvesmqcW22PAeK7E5ocRSxOwXQE9DnjoBa9ivZBjliGoSiFuWuSnRXM1n9bJ8HLqu
         28JoanFvolikGkaMiQL4UEFigQn4bfebfzPTZolytuvcUlkp59wucXgNBzKKl6TsvWID
         xvOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779188879; x=1779793679; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhTmhA7EtvBhVzOtpkjubbcdCBekT90z9FnlkG56Nt4=;
        b=NkzOT8mXh6bXhnJvqEtApaE4S4veNhy2u4ev1hghBlqH6x0n92yVBDsJ2dVI/ZJivu
         9A8hpggl+UV+EG+gZ3coLNVauocffm06kPS6Vsilr4oCfGSd+pU0V/7UWBN7MJ69Qwj4
         R1O1gypG77mvtOgIEZmtoiOoxIxx/0pznmMVmWyQ4agGZcSLDIFoxyo9RDUI+MxRlN+5
         IdgW+epOIw+p0gT6dT9gkmNG7DD8Tr7Gq7TAph8w2yFKfIgDr2gJ4ppcyT6UkCIFCNyf
         8Jw0CWqYMJEIAQUcdMZMca1DkDroniAfLQjNSAqdcZYDK/d8nqv1CAJ1GQZJXX93ZFJ9
         eCEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779188879; x=1779793679;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nhTmhA7EtvBhVzOtpkjubbcdCBekT90z9FnlkG56Nt4=;
        b=cC1g4sxZvj9s9gjhqoQF1vEtuEx7ZYyJtxO1itW8d3cTDP1opqPNGv7f0zZWs53sYP
         7uCGfkUxYKfZlmuJw3aLuoIFAE6wPUKuWHO0M4tp/l1j0X0U/FwTUrgPJ7qYRLmSaZ02
         r/qOF7CqDKq+7jrWqv+LEiUFG4L1k7cLWxBDzUvOS9cVAfDrs5g6ilipiyvLrRcC5yDb
         tOY/t+YTAfGEbR1twf1Abs0/ywjzorHGuitGbmjhWVFtUUN/D4xVNhOiCJ0ZDZn2AYqQ
         lkwc7usJmEEXReQsFUJFZjZAlg60En6Zww8BhUtokSh0yFzJ01GJwL9DsdbgWP1IKUzP
         Rr0g==
X-Forwarded-Encrypted: i=1; AFNElJ8xrkxiRrygqr3gYhEYu8LGAbRwltOQXsqMtDNv56mV5QXM6iXx12ihUykqeHX27Z/U86RL9CUa4YU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1ywwq4snvBmmF+VZKD8J9oq/iHrVCfoyG3eyowRy49aQWsIyj
	7iudnIh8lWycPOwhmRMoC49v+kHjpSvBIwtiBnKMeBi3ZueSUH+ky2T1eBmT4E4D5DujQzkXsN4
	muyrgBpjiu5q8OAtnGLEqahpjDLVU+Pk=
X-Gm-Gg: Acq92OExgErEJ/rGYIc/dXwxFVDzI5Ms1f4yjSoodrVwD461ceCKONG7Kgx+/34gFm5
	G9DeO3JJsF0+yCBNEtaVsCnoE6/SY2XKQc9XBl6nT73sl6XLCD39/EmLp+AdbnH9qOLEfS6RmXX
	UhfFEQkAxaKmY6c5M+ajwClv/Q8fgG+qeMjyNWaBRmpI9gUPYVDQFdl3XSE1nsPNyaYRkvobBVA
	jCeUc16PZbxjrMErhIY3w3nlYBshv/IZy63qhJGlvmyV6UYCuLhFLQS+wchiUCWCiH5hsYmePHK
	bbYUyunUN4WIE0scwPMbji6wW4cmS6ENBFpGQx0BguVyIJ6wBXfDPubomu19z9zM64wfyewZnYb
	ujXNeKUvFV0pnffsw7sN/nqU=
X-Received: by 2002:a05:7301:6785:b0:2f3:3835:2010 with SMTP id
 5a478bee46e88-3039870650cmr4323491eec.6.1779188879399; Tue, 19 May 2026
 04:07:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518042833.272221-1-enelsonmoore@gmail.com>
 <d40b1e80-37fc-4c88-9d7f-dae6458efe6c@app.fastmail.com> <20260518105735.GW3126523@noisy.programming.kicks-ass.net>
 <20260518172444.zyd47mcagrcwu7wt@dev-vm-schuster> <CADkSEUjhq6HSdg4ignzbuJiN5uXATsTdxFbRJ3BMxs5=WUWLDg@mail.gmail.com>
 <20260519103012.blot4bssgiqfer6p@dev-vm-schuster>
In-Reply-To: <20260519103012.blot4bssgiqfer6p@dev-vm-schuster>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 19 May 2026 13:07:46 +0200
X-Gm-Features: AVHnY4KWOiWEY77zuE66kq3xKsBRyVSkUGj1e6jCXaPb6QA3ygej9CY3aqSmM8c
Message-ID: <CANiq72=6oYtHf0Q1NaLXZ+25uQyYbej2xnvUhtgpHyvozhP7_Q@mail.gmail.com>
Subject: Re: [PATCH] nios2: remove the architecture
To: Simon Schuster <schuster.simon@siemens-energy.com>
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, Dinh Nguyen <dinguyen@kernel.org>, 
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org, 
	workflows@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, 
	dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-iio@vger.kernel.org, Netdev <netdev@vger.kernel.org>, 
	linux-pci@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Alex Shi <alexs@kernel.org>, 
	Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>, 
	Hu Haowen <2023002089@link.tyut.edu.cn>, Kees Cook <kees@kernel.org>, 
	Oleg Nesterov <oleg@redhat.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nicholas Piggin <npiggin@gmail.com>, Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Dave Penkler <dpenkler@gmail.com>, Andi Shyti <andi.shyti@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof WilczyDski <kwilczynski@kernel.org>, 
	Andreas Oetken <andreas.oetken@siemens-energy.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9000-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,sang-engineering.com,infradead.org,arndb.de,kernel.org,vger.kernel.org,lwn.net,linuxfoundation.org,linux.dev,hust.edu.cn,link.tyut.edu.cn,redhat.com,linux-foundation.org,baylibre.com,analog.com,lunn.ch,davemloft.net,google.com,siemens-energy.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[52];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,renesas,dt,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[siemens-energy.com:email,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 01CC557D74B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 12:41=E2=80=AFPM Simon Schuster
<schuster.simon@siemens-energy.com> wrote:
>
> Sure, I'd be glad to do so, but so far I refrained from it as I was a bit
> unsure about the netiquette (can I simply do so by self-proclamation? At
> least the git history seems to suggest so...).

Up to the existing maintainer, in general.

I would also suggest changing the support level to "Supported",
instead of "Maintained" -- that would help justify keeping it in
mainline.

I hope that helps a bit...

Cheers,
Miguel

