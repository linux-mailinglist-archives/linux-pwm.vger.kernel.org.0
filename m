Return-Path: <linux-pwm+bounces-7975-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGJiIsreb2n8RwAAu9opvQ
	(envelope-from <linux-pwm+bounces-7975-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Jan 2026 21:00:10 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1B04AEC5
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Jan 2026 21:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0BADE749313
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Jan 2026 18:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A858C44D6BA;
	Tue, 20 Jan 2026 18:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hg3XdnGN"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBDD44D005
	for <linux-pwm@vger.kernel.org>; Tue, 20 Jan 2026 18:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768932709; cv=none; b=RGmrDCNRKt7mwT4gC3BlP0LKRexVLYix0xR5Nt71sdS2vU+9dmfivQRsETgnjCUlhz7CpFWVmvDNoxIMaazOH52O68ApQ+TYhpBxB1RRIHQ/7UFuqhZHHKHG+hdGEanrX1VOew0KF3ITpmlL3aDhDg7acgT38sdjhuBsRrRVXjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768932709; c=relaxed/simple;
	bh=/QoiezmOLhh61y+Aix+i1K52HaWBtk6XiUnM2DzYxkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GFBn+AMvDJvGvkg11Tcv8rETwFIMuuHBpGsYpcPclMZGIOgJew5Q38VMsFUQsfl+hvqy96SFdzD8ROlWbKAAXU8D+lBuNRxuF34bERnVQ5To3Z2HJTcwdbXagpeKLMg46ffQLE0mZh+BZPEe/xNeIy8Q9XwG52HmyzChpJytzOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hg3XdnGN; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b872f1c31f1so760637566b.0
        for <linux-pwm@vger.kernel.org>; Tue, 20 Jan 2026 10:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1768932705; x=1769537505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eT9s+sqcEHCQ2wrfTXYnt90rVySQFkfJ/5S5Bg9l/EI=;
        b=hg3XdnGNgTwzx5xW1yDnc4It6wc7tpcRrLhzUGrGbWLVkqI+P7n6GtsKDLMBhTuSZq
         X0Z/6N/66dBKMV/Skm4SVX9SPXavel6dB41O46ezWGZOG8z4ElH9+f6V1bgVmyJv0AjG
         LtACFdZ7HtKqS8TxsLu1nsu4ntQ5nKY6rKbDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768932705; x=1769537505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eT9s+sqcEHCQ2wrfTXYnt90rVySQFkfJ/5S5Bg9l/EI=;
        b=YU2EKCshdQyGywGPmgfkHrnWNsZ0PSavKOSlvkqFtuadLGaBg7VXGCGxVa2rnIqfRG
         ze9lOc81nAIhGcVovx+cTBaj3ISG3v9n/htwDvq1TQjY6lSpUXrHWfkYgZPqJDBWtgMf
         kEJoT7BUvmG5zaNWmFB4GGhx5eR3FJH1gOC5GbcXI2N0KKbf5tKyWc5jwA/luymL8WNP
         J6AYPah8l5L4nXZq+BPphckPb9LyIsQ7AVQ1ikXvuxalMHibnEdPWx15jkm/HwFqfNux
         RgomjAh3zn/r5dqxWF7qS4/CG64Ie1RRJsDEFNCebWZTogiYu/pmW9cPRrvqRcNAFJPj
         ncrQ==
X-Gm-Message-State: AOJu0Yy4Dtu/jb1sFOfWyzbbF4KIaC+akUFkhoxe6EDmmv9ZUWCpxFXl
	hop4ZtlOhO+QISQN57ImrRQhPfnl0Inmdr4hzYfaIZ81oSFv0kZiJ38yMvlPRbkSAr9G3nAYg62
	Uoly/c0U=
X-Gm-Gg: AZuq6aIUnwjocpYu0QS0uNA0jbXMlSwFIF5JzAqdhx5H/salyfEGgBT1CC0xthzaiTw
	3qRH6ELIreEU612GtwXwAIpvhbw5OdLshLor/6jkMBEG1NrMBpp0j9Bnx00tou7EXwiD3fkt9yd
	ddDUrXOv65LV1mnQybMJlm2OEkR9SQerKQQxOPmhJpNGmt45QGHKMfNq9SZCMtgap8vpfWwFJbw
	1DH/wn2+1K9yAe/9UVN1qWGKDdtaEDrotbRGWrPZrm5FQbYfHIBXQNrl06UpOUW9rmBbHexWHaU
	1bAZXTgXA828ls0H78v410b7j4vI6DaamtbGI2SxLYiQo+k+QaF0Hy1GmmY56+1lpGOyfqjvXA2
	fD7Rk+NFPzriA+QliE9kkhsk2/h37jues2/zYdlY6HZ2izN6NL/00WqrQXrkhaXSP8NI/ewvIKC
	nMe78LEluMl/R5eiQaWRv7y4gV+YOuxMUwfR6K7M+WSPlJwNiFl2H9OZQUYxmW
X-Received: by 2002:a17:907:e11a:b0:b88:1232:cad1 with SMTP id a640c23a62f3a-b881232cc88mr103700666b.65.1768932704720;
        Tue, 20 Jan 2026 10:11:44 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b879513e951sm1431696666b.7.2026.01.20.10.11.44
        for <linux-pwm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 10:11:44 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b876798b97eso899748166b.1
        for <linux-pwm@vger.kernel.org>; Tue, 20 Jan 2026 10:11:44 -0800 (PST)
X-Received: by 2002:a17:907:961f:b0:b87:d722:f824 with SMTP id
 a640c23a62f3a-b88006ec2c4mr247492566b.63.1768932704087; Tue, 20 Jan 2026
 10:11:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ahytfwrx6d7nvddjviqt6wyit6f7flh5vmiuuzdet44unjdbwp@cktsraaj56au>
In-Reply-To: <ahytfwrx6d7nvddjviqt6wyit6f7flh5vmiuuzdet44unjdbwp@cktsraaj56au>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 20 Jan 2026 10:11:27 -0800
X-Gmail-Original-Message-ID: <CAHk-=wga8Qu0-OSE9VZbviq9GuqwhPhLUXeAt-S7_9+fMCLkKg@mail.gmail.com>
X-Gm-Features: AZwV_QiO1b0dLTbV3VTgXA2ZKpydu0G0XFtUzcJWV3dzANQTfWFWlzSBabInqTo
Message-ID: <CAHk-=wga8Qu0-OSE9VZbviq9GuqwhPhLUXeAt-S7_9+fMCLkKg@mail.gmail.com>
Subject: Re: [GIT PULL] pwm: Two fixes and a maintainer update
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michal Wilczynski <m.wilczynski@samsung.com>, Richard Genoud <richard.genoud@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7975-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,linux-pwm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-pwm];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,mail.gmail.com:mid,baylibre.com:email,linux-foundation.org:dkim]
X-Rspamd-Queue-Id: 3A1B04AEC5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 20 Jan 2026 at 01:32, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
>    You might argue that this is an ABI change [..]

Pretty much any change can be an ABI change - even totally new
interfaces change behavior in that something that didn't use to do
anything now does something.

And we've actually very much have had things like that happen too,
when broken user space did something odd, and adding a completely new
file in /proc (or something like that) just broke broken user space.

And any bugfix that changes visible behavior is also an "ABI change",
and so there is no practical meaning to the whole otion.

So I absolutely detest the whole notion of "ABI changes". It's a
meaningless concept, and I hate it with a passion, because it then
results in the "opposite" situation where some projects seem to think
that ABI changes are perfectly fine as long as they go along with
version number changes.

The Linux rule for regressions is basically based on the philosophical
question of "If a tree falls in the forest, and nobody is around to
hear it, does it make a sound?".

So the only thing that matters is if something breaks user-*conscious* beha=
vior.

And when that happens, the distinction between "bug fix" and "new
feature" and "ABI change" matters not one whit, and the change needs
to be done differently.

Anyway, I agree that the whole "return proper -EFAULT on user copy
failures" is clearly the right thing to do, and I do not disagree with
the patch at all.

I just wanted to point out that the argument about whether it's an ABI
change or not is irrelevant. If it turns out that some program - not a
test script, but something with relevance to conscious user
expectations - depended on the old broken behavior, then it needs to
be done some other way.

So whether somebody "argues" that the change is an ABI change or not
is simply not relevant to anything.

Obviously some changes are more likely to be user-visible than others,
so people should take that into account in how careful you need to be
about a patch.

This one looks entirely benign, but I wanted to point out that if it
breaks some program - however unlikely that is - it just needs to be
reverted, and it doesn't matter what the change is called.

                     Linus

