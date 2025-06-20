Return-Path: <linux-pwm+bounces-6451-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 389F3AE109B
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Jun 2025 03:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F5257AA781
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Jun 2025 01:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568962030A;
	Fri, 20 Jun 2025 01:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+YKKIr8"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9702F2E;
	Fri, 20 Jun 2025 01:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750382089; cv=none; b=Ntmtt8cYzG6jnruoUZkjk6nS6KfgrYMRqBgeFJDS+mKytO60KE1fodqpegc0XdjOhyzG6uX3KW5tIM+aG88TmxX3BQyWVbdNkBecbaMzxSg61ZKC/eTJX7QvZXMzHAnifpWMJf1EmYa4z2rdvzwFDsn4+VWdlfzWv1eqZwzJ/40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750382089; c=relaxed/simple;
	bh=lJdtEbwauCEoV6G/jsOy7MaN56Y4ZZBnOmmjPdBsfq4=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=bJEOtz+s3AmlzuFHVhF1oFP9jvNrVpKfPMNJcbVln7i/qR0Px1NpB4YuuEBZH/Hl5l6ds9uy9ushOSIr89oe3cHfvHAInVSf+ene7PQUxPvkeCcd7UImjUJgAwxwLaoIIALkBv+miDj4Q1bssWZpBlCFYRRZTu8Tthlun5QwDbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+YKKIr8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C70C4CEEA;
	Fri, 20 Jun 2025 01:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750382088;
	bh=lJdtEbwauCEoV6G/jsOy7MaN56Y4ZZBnOmmjPdBsfq4=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=f+YKKIr8nun5FR5emikeZG1K7iX8bnr+3jJculDJcTTHJuXdWR60PJ/mjfVWVY19T
	 sfr6pzvBFFcBJCjFwFweSts1LXisLMZFOqBAk6dkmIRnfsa6VR7xxrsEAcGMWKKBu9
	 /nsuFfYxWXSSB9MaWMU9nuucZhhxFcNIxjvOU1/EXtrOv0CSAzPQqijeR0/av5QNrD
	 +bnnJRWk3h/tNRwLhcSw2a7LfkeV3U4CWGY8bzKo57l1/HLAD6rmwXshCCRi4m6XeA
	 7yYOpJzDHARbzCz5MSbt3WY6MA1weepkoJQNSMbU5QxhLEDXAIKXX8ydHm0KhJUgQ9
	 PoGBCBil0qTIA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <f194fad5ee8bdd3fda6159324524979729683653.1746006578.git.ukleinek@baylibre.com>
References: <cover.1746006578.git.ukleinek@baylibre.com> <f194fad5ee8bdd3fda6159324524979729683653.1746006578.git.ukleinek@baylibre.com>
Subject: Re: [PATCH 2/4] clk: pwm: Convert to use pwm_apply_might_sleep()
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-pwm@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Date: Thu, 19 Jun 2025 18:14:48 -0700
Message-ID: <175038208800.4372.7518153426310159395@lazor>
User-Agent: alot/0.11

Quoting Uwe Kleine-K=C3=B6nig (2025-04-30 02:57:47)
> pwm_config() is an old function that I'd like to remove. So convert this
> driver to use pwm_apply_might_sleep().
>=20
> There is a minor change in behaviour as the explicitly calculated
> duty_cycle used an uprounding division while pwm_set_relative_duty_cycle()
> rounds down. I don't expect that difference to matter in practice though.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> ---

Applied to clk-next

