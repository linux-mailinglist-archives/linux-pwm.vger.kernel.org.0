Return-Path: <linux-pwm+bounces-2937-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9830594148C
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Jul 2024 16:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C997C1C211DB
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Jul 2024 14:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34791A01C9;
	Tue, 30 Jul 2024 14:38:39 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F21519DF41;
	Tue, 30 Jul 2024 14:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722350319; cv=none; b=FgQGSy1HEH/nixr3MeVyMem/d2vwY5/ondHxy3epcjFbq+UAIHy0fEyj1wbAx44BKjyvbTOUxI5jZm7pt7wh9FYjvmgrr3SvUNN9VqmFvQKjVbLCSoz+rsvh0EBjWSP4j6yZ1opv/8OFz0FL2S3lPPdEpPwRHi9BN6dIi8JpyLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722350319; c=relaxed/simple;
	bh=h4A0xXdUQHhHk7YmWnMN0erA0Zqv9R6gZQTjp7b8oeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H91PL1CTKqF+4eFopg4eNTZnI0NHBQ9w10q8XzA68jtnyjcceHBbNQGEJ/Dlx62Jcyi0e4Iu0m7bsg6Ocp6A0d8t4om496/uLRlG724WEBcrh0+Ld/diO+dhyOuuXlEQIOb/tDzgUkptON7aDgC47gZvLy152Ygo8q5Is0doN+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6726DC32782;
	Tue, 30 Jul 2024 14:38:38 +0000 (UTC)
Date: Tue, 30 Jul 2024 10:39:10 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-pwm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: Make info in traces about affected pwm more useful
Message-ID: <20240730103910.6de49acf@gandalf.local.home>
In-Reply-To: <qye5vuh5hzoemdciohq3x4oofjpvw6pwe777loqacqfmhf4grg@5gtprhv3g377>
References: <20240705211452.1157967-2-u.kleine-koenig@baylibre.com>
	<qye5vuh5hzoemdciohq3x4oofjpvw6pwe777loqacqfmhf4grg@5gtprhv3g377>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 30 Jul 2024 09:22:53 +0200
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote:

> I think the patch is obvious enough to be ok even without the tracing
> maintainer's blessing. I applied it to
> https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/fo=
r-next
> .

No problem. Thanks for the Cc. I don't always reply if the patch is pretty
straight forward. But I do look for things like holes in the TP_struct()
portion, that would waste ring buffer space. As well as uses of
dereferencing pointers.

-- Steve

