Return-Path: <linux-pwm+bounces-1482-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3BD854754
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 11:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DA761C271A5
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907E018E20;
	Wed, 14 Feb 2024 10:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X+Y31rbE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6734B16423;
	Wed, 14 Feb 2024 10:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707907232; cv=none; b=KRp7wnTEDGaFwQxlaMdYyxLF8dl1pfb5H1QmgOhcGwkk7iSE/giKdmcBu/apOGot+umytkggi6np7g9x5zhwt9fYBT3pAQNzp4GMmRyWZpKSAgogCzBJApm8uhIy/tL0yvBwdfZkpZ7v9tmAYG2X7YmHl3ZkQ8p6kL/DirGi718=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707907232; c=relaxed/simple;
	bh=EpjYyt0914fkjyyAJyuzKwow917LLFcctHLrUPJnYgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMgkDQTpIH0a9e+gzBDJNuH4yYHOF2uaitzu4s1wJVy+G5ATLMI1+PqmquYx3hnfYI69uvqdeVpYppt63zYFLidiyIDZ8RPr6i+Yv7RpTdwRE3YX3XsEFrfDGusZO5jkiZ3yIXH2sXm7tVxrtdM/WcguqzkyYz7snHMs+EoYmDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X+Y31rbE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA925C433C7;
	Wed, 14 Feb 2024 10:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707907232;
	bh=EpjYyt0914fkjyyAJyuzKwow917LLFcctHLrUPJnYgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X+Y31rbE34ozGbHICc8xPXK7/Mgrb/tDFdecSygJmB4rauQ3Y/YBf3taMAShCy9El
	 lREgOqtzwvIUcvZJV76nGVJF4VvVdpPVNA8eiQbBgPLAYtN8p/kvPGQhCN7k4ZS2KH
	 aVm15pkQ5hP0lj6BwIM4vqA0OhWkgYW+MVaoACgg=
Date: Wed, 14 Feb 2024 11:40:27 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>, greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev, kernel@pengutronix.de
Subject: Re: [PATCH v6 159/164] staging: greybus: pwm: Rework how the number
 of PWM lines is determined
Message-ID: <2024021408-anyone-dreamy-3734@gregkh>
References: <cover.1707900770.git.u.kleine-koenig@pengutronix.de>
 <3efd84ac03e7dc288f20b0de20b142b6404cb1fa.1707900770.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3efd84ac03e7dc288f20b0de20b142b6404cb1fa.1707900770.git.u.kleine-koenig@pengutronix.de>

On Wed, Feb 14, 2024 at 10:33:26AM +0100, Uwe Kleine-König wrote:
> With a later patch it becomes necessary to already now the number of PWM
> lines when pwmc is allocated. So make the function not use pwmc but a
> plain connection and return the number of lines instead of storing it in
> pwmc. This allows to get rid of the pwm_max member.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

