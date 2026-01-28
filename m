Return-Path: <linux-pwm+bounces-8009-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIi1AJ9Gemkp5AEAu9opvQ
	(envelope-from <linux-pwm+bounces-8009-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 28 Jan 2026 18:25:51 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B29A6D1E
	for <lists+linux-pwm@lfdr.de>; Wed, 28 Jan 2026 18:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 09F0030066B4
	for <lists+linux-pwm@lfdr.de>; Wed, 28 Jan 2026 17:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4FF319855;
	Wed, 28 Jan 2026 17:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="E73v6zmG"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6892265623
	for <linux-pwm@vger.kernel.org>; Wed, 28 Jan 2026 17:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769621145; cv=none; b=oRl+ftpi66lYfw5BdEqAiLMOxTh+GTbHqXWjfXSnG0xZ5fNSsWNsIR4EK8iLwv5/SgJrHa8i6gPUZJCebA9/gmWAFe9wUuHK3sq3gh+e2+XDJ3vavoFt9zMi4AQ1kLDtjmVU8w1bqJ6pkniSYQjpTk1nwL3ToO4mewTMY2pBZeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769621145; c=relaxed/simple;
	bh=Wbr/a0Cn/O+6vwXK0w5x39O7ceC5hqlk6aFRfoLthJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ml3PUMeYTFcrJAYifExqCAA9lVr3HMqkibMPQ4dtK8+LnDkckAeCnOI4ti5yva6N0G5mE64FpV5nLuHte1u5tuICl0L//nTitgk3BrcxAVj6Rm9eGV1dL6eWwpmRu8L+mYme4ur6b2X2rDVmwn5PF441VyrLpFdoMnXLhcbmMmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=E73v6zmG; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b885e8c6700so16503266b.0
        for <linux-pwm@vger.kernel.org>; Wed, 28 Jan 2026 09:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1769621142; x=1770225942; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vTfzzC7PZC7Pn6jCxF4P3ReBh47wYycrOH2+9W5x00g=;
        b=E73v6zmGVgU9ptXrNEuHbaT+tWyMA5wV8iZBCwbu+QnMX2PDtBq+MDfVySWIa9fhTH
         0b91Q+ALMrwN7642uvRXn8qIwP+RN8/mgVJXyLaL9Kxd1K8B88qXtxZJUATOo0oIzYie
         4ri+qZ5iANRx0nQhJ1BBjU4B9BVjzQU3vJ1Sw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769621142; x=1770225942;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vTfzzC7PZC7Pn6jCxF4P3ReBh47wYycrOH2+9W5x00g=;
        b=ElHU4vo4TTY5dWslcnC/W+cPS5wRdtuLFF48ZqiU8G2KVWxCUlJY91BLMjcqqQVDIY
         D1OxrmohRS4lSmodA6c+RBW/XmRHcCkAs9gU2OgBt9vdSvrXeRuCAjHkL1U2xSvoJwvg
         cMfUCXG2ESw/ArbMyN5PYss23iy4N33HW95tPTnTye633cKs0k6D2+caMgLfucVNMTef
         +nCkjttBYHUhQX1eSYaTcO6g+F+4A2VEtKPMEwnG4OgZZV4NFFAMPmEQY3zDxhLi4QkJ
         /zZU30NXH4t34TBNoEfdAgDFZgjUFg518qHTt/13oaG4mWslUWzuAnoP3PlOz8yuaB7w
         YdPQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4430hM4KwYRzRieu5jcNW3aYEyRX8KvC0Fa/8nm1EHgRR4rVIeDoPZAcqzNNfe2DHeXfgN7qikGo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8Ayi8SA8GFho9iQ2MqqlQBBeRy6ZpvmmBq7Dm0rMTn4iUo8Cp
	fnHGV8ofMoDQGU1KfyhOVzOW27njZjhMCZ+KSmYnT+CM5Q8/q7Ha9Dxxh97qTCxlKN8WC5vy9zh
	JaKf25hKYGA==
X-Gm-Gg: AZuq6aL5Cw24W7w5cnNK1jdg0rGPgJBBaIuRdx5s4B0qon94bKPiR4xHA5zwe2JXRpi
	n8RdILH7hV8Goi0KhpXxqVxeagqT69XQvsTNmC4J5N+q2MiWo6g2asFCXaJBZwzAtceC5Rf/6/q
	5ptJnH04eFdajS2+jiI0yQJWFtlmTyVycWxuQks1ScwrLw6WvSmFq+RFbyhSOt0+fQtsek+X0Vg
	kaRxG102cTV+WKJIUM1igrNsLim+I69Wcac/JcfDQhn4GUagvHHajBYpGoXp5FrsahIOFpzHJ4S
	cz7yvEZSPnNTDFH/canWacCZVdqd2ypzlbe9P6GPQPii6NI57wNp8ekMzB9KWi3DVhcboRmvWel
	CFEmrEor20+aStonVZ0NsWOPeCuqtrH819DAeI3ltJy50zCcHvDESVFyusctxjMZLA1vtChPzio
	Onft3neoTtJ0a3vmLxMr1q18W9XAyeG+Nnee+B0667JJo0eY978NHo7/ynixF0
X-Received: by 2002:a17:906:f58a:b0:b87:fad:442b with SMTP id a640c23a62f3a-b8dab28d5abmr411923266b.3.1769621142131;
        Wed, 28 Jan 2026 09:25:42 -0800 (PST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbf184e5dsm153795666b.43.2026.01.28.09.25.41
        for <linux-pwm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 09:25:41 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b885e8c6700so16500566b.0
        for <linux-pwm@vger.kernel.org>; Wed, 28 Jan 2026 09:25:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX5a9jNcbhbjQSlOStpZgcxXexDv6qE1EygMCEb5zcCn9JpQAfFtw6ma2WE6A/pyYKuYGrIZwLBqnY=@vger.kernel.org
X-Received: by 2002:a17:907:7b85:b0:b87:6:3727 with SMTP id
 a640c23a62f3a-b8dab4458d1mr502078766b.48.1769621141165; Wed, 28 Jan 2026
 09:25:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ahytfwrx6d7nvddjviqt6wyit6f7flh5vmiuuzdet44unjdbwp@cktsraaj56au>
 <CAHk-=wga8Qu0-OSE9VZbviq9GuqwhPhLUXeAt-S7_9+fMCLkKg@mail.gmail.com>
 <20260122-bold-sticky-wapiti-1dffa2@houat> <CAHk-=wheQNiW_WtHGO7bKkT7Uib-p+ai2JP9M+z+FYcZ6CAxYA@mail.gmail.com>
 <1f9ecc30-1624-4d2b-aa86-a1f0dff6b97a@leemhuis.info>
In-Reply-To: <1f9ecc30-1624-4d2b-aa86-a1f0dff6b97a@leemhuis.info>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 28 Jan 2026 09:25:24 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi86AosXs66-yi54+mpQjPu0upxB8ZAfG+LsMyJmcuMSA@mail.gmail.com>
X-Gm-Features: AZwV_Qhp5tzXp068T9kVMXUzVmuWSg3GdGan2eE75m5nMzdeaRqB94dLBe9l0bw
Message-ID: <CAHk-=wi86AosXs66-yi54+mpQjPu0upxB8ZAfG+LsMyJmcuMSA@mail.gmail.com>
Subject: Re: "immediate fixes" for user-reported regressions (was: Re: [GIT
 PULL] pwm: Two fixes and a maintainer update)
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michal Wilczynski <m.wilczynski@samsung.com>, Maxime Ripard <mripard@redhat.com>, 
	Richard Genoud <richard.genoud@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	TAGGED_FROM(0.00)[bounces-8009-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,linux-pwm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux-foundation.org:dkim,leemhuis.info:email]
X-Rspamd-Queue-Id: 98B29A6D1E
X-Rspamd-Action: no action

On Wed, 28 Jan 2026 at 08:12, Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> So how can I/we make "immediate fixes" happen more often without
> contributing to maintainer burnout?

This is partly why I mentioned the "revert and rethink" model. A lot
of maintainers already do that for late regressions because they don't
want to have a hurried fix late in the rc, but I think it's just often
a good idea in general unless there's just an obvious fix for an
obvious bug (and often it really is obvious once somebody reports
problems and the commit that caused them has been pinpointed).

Exactly so that maintainers don't get stressed out over having a
pending problem report that people keep pestering them about.

I think people are sometimes a bit too bought into whatever changes
they made, and reverting is seen as "too drastic", but I think it's
often the quick and easy solution for when there isn't some obvious
response to a regression report.

It's also worth noting that "immediate" obviously doesn't mean "right
this *second* when the problem has been reported".

But if it's a regression with a known commit that caused it, I think
the rule of thumb should generally be "within a week", preferably
before the next rc.

> We could obviously start bypassing the regular channels occasionally
> when no "immediate fix" comes forward through them if that's what you
> want.

I do actually do that when something hasn't been fixed and people
point out a known fix (or revert) that has been pending for weeks and
causes problems for people.

Of course, by the time something is at the point where it's been
escalated to me, it usually means that it's really been _way_ too
long. So that's not the good case.

                Linus

