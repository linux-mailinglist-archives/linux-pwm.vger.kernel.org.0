Return-Path: <linux-pwm+bounces-7990-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPsKK/ZncmmrjwAAu9opvQ
	(envelope-from <linux-pwm+bounces-7990-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 22 Jan 2026 19:09:58 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F02C76C06C
	for <lists+linux-pwm@lfdr.de>; Thu, 22 Jan 2026 19:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2FD53009F90
	for <lists+linux-pwm@lfdr.de>; Thu, 22 Jan 2026 18:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9994B34EF1C;
	Thu, 22 Jan 2026 18:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="coUXOZgI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75AB324B0C
	for <linux-pwm@vger.kernel.org>; Thu, 22 Jan 2026 18:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769105307; cv=none; b=Yoa9gsfXhyOgi5Ie70ZnSAsL+89dS2E4K1tkOlN0eYZnx3jLssj9fQoibO2/KjL1/TZSnrUTDPiY9kQuM53XGJJyl0o9eT5A8peG9eW4AzI6ijycyNtR+er/DbHV/eo/tIJGUU3zejxVO7e4YuZaQNckcbAZMjDjK5ljyUG7rU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769105307; c=relaxed/simple;
	bh=Y6q60xrn1CY3EIrBDvVdSfsuadY5DTdYGS1Z4YfJ44s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sPug1EFbHuXg5coj1oRccHdCg5mA7jdpLIPJj0ppWOm4k1AxN5lfweEJe7pZQ/rbTxlG+6xYEM6uwIGbnauFR4vqU/SeqYsCS00qBjeCpA8yc+xR8PJqzy4rj7UoMGP/0p7eFampDlRTlrdym34G9sFEh4hiaBQPVy/p4Z254m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=coUXOZgI; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b885a18f620so18700566b.3
        for <linux-pwm@vger.kernel.org>; Thu, 22 Jan 2026 10:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1769105294; x=1769710094; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n4LWbSRpoTfx8DbYtRKRbrlwN5G2PUa5SlyEf1trkTU=;
        b=coUXOZgI0vzq1RqOHvrfd3imTP5MYaxX3nnIxs/m2s9w8BWsraEqhHiKph94VfHq53
         5OofxRCZhvSsBfJFDbMTQoAyAiNHpoyYFsnE5rlahkOcf+suM5J0IPL2Lsg89lr4N4Sw
         g6zzAijvkqJXvTw98gh23LIxEAK8jyEE81sYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769105294; x=1769710094;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n4LWbSRpoTfx8DbYtRKRbrlwN5G2PUa5SlyEf1trkTU=;
        b=Pp+8XTKQwnFiitGgpJkBte2QnTXjMDCMK8HWC1XI1b5+5X2LfvohQFyO1VF6lPvl0C
         c+0zj9I+tC91mWQ6sSLWq3YtPoj4c0/Kp/QMlToBYEf1S1HgNJ2gO9V9qmkDdXLMqq2y
         5B1Q2796WZdZz4bgs3nAhJJqtmRF7pKiIH541pW8fWqaRLB0TCvkPAtpJ5fd24X0qhua
         cg71e8D8ZYpVtykizcnBftbgObaviIQVSmiQ6oCum9nPiEAJdH4vlvwLq6KtbbZ4EPc6
         l1JW1uAhtFjDNbW79Ndsv5d7A5/I3+lj/0YYVJO+J/5TTob6+7N7H8DjEh7Xb5Ck4Tm0
         IVWw==
X-Forwarded-Encrypted: i=1; AJvYcCW+gCEYwdWsvgXxtFe/OgmlIfirQavYBpWdqC3XXTThZ1kNSPLpX697kqoMzFsnx4QEYQvdpm/dzl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJiagfMNI6U3KUJyq2igb6Ic06TYIN1McrHA/Y06C18Z/CEfAL
	B9K6nQ0GQ5XaeKupJZxitVHzfXFdpcLxh0owXEkdKnRRBrAgiRTZxz4N3RweQLtCPT+WugrkBGn
	2Z4lbLqA=
X-Gm-Gg: AZuq6aIcwdmc6K8L5SHMQgqdKdymgkURCZn3bwGv4k5GqC3+cQXKNZK3uVWRkgMmnSB
	gg31R2HBDcGBL/ExzXTi0DKPCqQw7l1jKFq653rRM5Mp3I+5MCog7oVFrw8v4jWjsauQKW09zrh
	+gWDO+dijzy70n+XLcn5agTNNQQ9Nc4RiCpuPgwQNtx46OvMZ6PLTnhDTjCqtgBEk2JNurgfcyp
	XGTHoqURIRCFqcnb4kKfnMJxkhlDxoVC+AzlzDqRSNaUzgB6BZ2Lcqvg1ph7RNzi1xGl9n3eXVO
	ZaXn9W8OedltVpGlmiOHf2iMapiR2s2yMu8/IML8j6fKNf8PSgQpCHY1vv9IR+PhCSNN2yl36xK
	QdAmmRg+FYDJyQ/mq3/crM3N0r8k2WwFehs5VncoRUVHPaPD2moHuSlobzWgOz5cacjBwT28ECk
	/xIEP3iAW1BZtyHq5E+w9tL1taBcOeY+7N2KgSu/RUepKIpNr9kIyR44+NvQ/NRv0VS9CQxMY=
X-Received: by 2002:a17:907:3f17:b0:b87:117f:b6ed with SMTP id a640c23a62f3a-b885acca601mr11111666b.21.1769105294330;
        Thu, 22 Jan 2026 10:08:14 -0800 (PST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6584b955523sm64644a12.26.2026.01.22.10.08.13
        for <linux-pwm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 10:08:13 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b86f3e88d4dso167958566b.0
        for <linux-pwm@vger.kernel.org>; Thu, 22 Jan 2026 10:08:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU28vLYXxZgRt2Ob6gPGqtIAUjbc1wOA+D+Iiv2sSpCdJ9B7znwIuPtdwhNT0c9QWC0sDayeCS01O0=@vger.kernel.org
X-Received: by 2002:a17:907:2d92:b0:b87:3174:9bbe with SMTP id
 a640c23a62f3a-b885af0890cmr7212866b.61.1769105292900; Thu, 22 Jan 2026
 10:08:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ahytfwrx6d7nvddjviqt6wyit6f7flh5vmiuuzdet44unjdbwp@cktsraaj56au>
 <CAHk-=wga8Qu0-OSE9VZbviq9GuqwhPhLUXeAt-S7_9+fMCLkKg@mail.gmail.com> <20260122-bold-sticky-wapiti-1dffa2@houat>
In-Reply-To: <20260122-bold-sticky-wapiti-1dffa2@houat>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 22 Jan 2026 10:07:56 -0800
X-Gmail-Original-Message-ID: <CAHk-=wheQNiW_WtHGO7bKkT7Uib-p+ai2JP9M+z+FYcZ6CAxYA@mail.gmail.com>
X-Gm-Features: AZwV_QhnXIhWoEMDJsEBbAYKmsqgpZOb7D77FthmHx6jj6F7jevftC5yxdhucSk
Message-ID: <CAHk-=wheQNiW_WtHGO7bKkT7Uib-p+ai2JP9M+z+FYcZ6CAxYA@mail.gmail.com>
Subject: Re: [GIT PULL] pwm: Two fixes and a maintainer update
To: Maxime Ripard <mripard@redhat.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michal Wilczynski <m.wilczynski@samsung.com>, Richard Genoud <richard.genoud@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7990-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,linux-pwm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-pwm];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:dkim,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F02C76C06C
X-Rspamd-Action: no action

On Thu, 22 Jan 2026 at 06:39, Maxime Ripard <mripard@redhat.com> wrote:
>
> >
> > Obviously some changes are more likely to be user-visible than others,
> > so people should take that into account in how careful you need to be
> > about a patch.
>
> Where do we draw the line then, if there's any?

Users complaining is the only real line in the end.

So something like a test-suite complaining is then often a *very* good
indication that maybe users will hit some problem, and test suite
issues should be taken very seriously just because they might be the
first sign of upcoming trouble, and the earlier something is caught
and fixed, the easier it's going to be.

But a test-suite error isn't necessarily where you have to draw the
line - it's a big red flag, but it *could* be something like "the
error checking was done in a different order, and the error number
changed in some situations, but it doesn't actually change behavior
except for the error message that is printed".

So then a test suite failure is a "let's ignore it, but keep an eye on
it in case some program really did care about that *particular* error
number".

But a user complaining should basically result in an immediate fix -
possibly a "revert and rethink".

So a user complaining about some kernel change breaking their flow is
when you don't even start arguing. The issue is over and done, and the
change needs to be undone.

There are _very_ few exceptions to that rule, the main one being "the
problem was a fundamental huge and gaping security issue and we *had*
to make that change, and we couldn't even make your limited use-case
just continue to work".

The other exception is "the problem was reported years after it was
introduced, and now most people rely on the new behavior".

But starting to argue about users reporting breaking changes is
basically the final line for me. I have a couple of people that I have
in my spam block-list and refuse to have anything to do with, and they
have generally been about exactly that.

Note how it's not about making mistakes and _causing_ the regression.
That's normal. That's development. But then arguing about it is a
no-no.

So in the kernel tree, we don't argue about regressions. We fix them.
That's basically the only really hard rule I have.

Almost everything else is "just explain it, we have various rules for
development, but rules are meant to be broken". Not the user-reported
regression one.

> Should we just consider those drivers "wrong", treat it as a bugfix, and
> expect userspace applications to request the format they actually rely
> on? Or should we continue what we've tried to do and try to support the
> right format, and the old format for backward compatibility?

If it used to work, and people relied on it, you add a new "right"
format, and keep the old one around. Possibly with some hack to only
affect some particular special case, with the hope that the special
case and hack can be removed.

Now, if it's one or two users and you can just get them to recompile,
that's one thing. Niche hardware and odd use-cases can sometimes be
solved that way, and regressions can sometimes be fixed by handholding
every single reporter if the reporter is willing and able to change
his or her workflow.

But the basic rule is: be so good about backwards compatibility that
users never have to worry about upgrading. They should absolutely feel
confident that any kernel-reported problem will either be solved, or
have an easy solution that is appropriate for *them* (ie a
non-technical user shouldn't be expected to be able to do a lot).

Because the last thing we want is people holding back from trying new kernels.

                  Linus

