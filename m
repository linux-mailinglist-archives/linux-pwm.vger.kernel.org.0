Return-Path: <linux-pwm+bounces-8007-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFUQGhk3eml+4gEAu9opvQ
	(envelope-from <linux-pwm+bounces-8007-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 28 Jan 2026 17:19:37 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F38FEA56C0
	for <lists+linux-pwm@lfdr.de>; Wed, 28 Jan 2026 17:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B96D6305BD74
	for <lists+linux-pwm@lfdr.de>; Wed, 28 Jan 2026 16:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9E730CDBE;
	Wed, 28 Jan 2026 16:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="mWqXhsXt"
X-Original-To: linux-pwm@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59836308F2E;
	Wed, 28 Jan 2026 16:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769616741; cv=none; b=VFPbuc66yXCrd57wMyBlJeg1Yj2CtJqJrBpQ4x7sIWsPU8XcY0Vq2cYt2SqxkNuZYJ9sCWOyrCkdnvlQraE5J9EDGKbRK37/BfMLRIyYeJklj/Ntj7QBYtSlhxW+o4h97cSPLjR8bK9YYrnyJ0/q4RUeDG5x+JbLYl9D41Nui2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769616741; c=relaxed/simple;
	bh=Q9WA9cPZq+5pLcmUo72rBQo5NIr/+V71KRLBOt/gXNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tVdYlO4zmSIm8CjQrp2KOilxHmIE01XqJIwhEOwxQYFm/OsH1EgHz0lwHTHdv829LbVAVkRpan0XliYfaw92woI00WVrgt2zmrzWy/VKod9xQrrNMkaU1gQ8Av5GisBgm/Gi3hkhPP3p42hlSWHO6XQYKDby2ECGPfh1VLEYyDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=mWqXhsXt; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=Q9WA9cPZq+5pLcmUo72rBQo5NIr/+V71KRLBOt/gXNo=; t=1769616739;
	x=1770048739; b=mWqXhsXtGHKLlwiOT+YhHQbT9jN7v230jwWCxEjWUsXdDMFe2irM1UHxZWD7t
	4Uuwxjtb5ha2yY5hTUslCYZpLYY5hSr+gm3qzJ/9f6lQZ09TXsDVyGhz7Pk1672hcmT+mgdQL7T5w
	DiZp4drafm1heVTwulDTyPHHDMWhYX4nDKc+zEorl0lmgPWNShGoLBWnJWitNUhPTRK0kSbJZ+tjc
	5NA4c5WDsa2vK/kTByPIHkvT1sEY4Xb7LoexOyr+ise7JmY+7fAjzs13r5QjrZcqxORLfMKtjMXuq
	55tOjlxovzR7l7LtOmASrW1HhlbgprsWDK2KIpBGeQhMXhIjCg==;
Received: from [2a02:8108:8984:1d00:a0cf:1912:4be:477f]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	id 1vl89R-003RbB-06;
	Wed, 28 Jan 2026 17:12:17 +0100
Message-ID: <1f9ecc30-1624-4d2b-aa86-a1f0dff6b97a@leemhuis.info>
Date: Wed, 28 Jan 2026 17:12:16 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: "immediate fixes" for user-reported regressions (was: Re: [GIT PULL]
 pwm: Two fixes and a maintainer update)
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Michal Wilczynski <m.wilczynski@samsung.com>,
 Maxime Ripard <mripard@redhat.com>,
 Richard Genoud <richard.genoud@bootlin.com>
References: <ahytfwrx6d7nvddjviqt6wyit6f7flh5vmiuuzdet44unjdbwp@cktsraaj56au>
 <CAHk-=wga8Qu0-OSE9VZbviq9GuqwhPhLUXeAt-S7_9+fMCLkKg@mail.gmail.com>
 <20260122-bold-sticky-wapiti-1dffa2@houat>
 <CAHk-=wheQNiW_WtHGO7bKkT7Uib-p+ai2JP9M+z+FYcZ6CAxYA@mail.gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <CAHk-=wheQNiW_WtHGO7bKkT7Uib-p+ai2JP9M+z+FYcZ6CAxYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1769616739;a9fe7a9d;
X-HE-SMSGID: 1vl89R-003RbB-06
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[leemhuis.info:s=he214686];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8007-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[leemhuis.info];
	DKIM_TRACE(0.00)[leemhuis.info:+];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[regressions@leemhuis.info,linux-pwm@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F38FEA56C0
X-Rspamd-Action: no action

On 1/22/26 19:07, Linus Torvalds wrote:

> But a user complaining should basically result in an immediate fix -
> possibly a "revert and rethink".

So how can I/we make "immediate fixes" happen more often without
contributing to maintainer burnout?

Because I see quite a few user-reported regressions that take quite a
while to get resolved. I usually tried prodding maintainers, but well,
that led to major complaints reg. maintainer burnout and in one case
contributed to a maintainer stepping down. And many of those complaints
even happened with simple cases, like me prodding when (a) fixes/reverts
with a Tested-by: from the reporter were waiting on the list for review
and merging for one or two weeks or (b) were merged in the right
subsystem tree already for a similar timeframe and just not sent along.

And I can even understand that, as maintainers have a lot on their plate
already and sometimes need a break, too.

We could obviously start bypassing the regular channels occasionally
when no "immediate fix" comes forward through them if that's what you
want. I could, for example, point you to fixes for recent regressions or
even collect and send them your way when they fall into one of these
categories:
- Reverts that I or someone else submitted that got a Tested-by: from
the reporter.
- Unreviewed fixes that got a Tested-by: from the reporter and no "this
is all wrong" complaints from the developers within a two or three days.
- Fixes cherry-picked from the subsystem trees not sent along.
- Fixes maintainers ask me to pick up to send along.

But well, bypassing the regular channels obviously has it's downsides,
as things are more likely to get wrong that way. But I guess if you
really want "immediate fixes" for user-reported regressions, we afaics
likely need something like that. Unless you have a better idea.

Ciao, Thorsten

