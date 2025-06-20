Return-Path: <linux-pwm+bounces-6450-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F65AE1097
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Jun 2025 03:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 760EB17B3C9
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Jun 2025 01:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4DA2030A;
	Fri, 20 Jun 2025 01:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rRTXi0LN"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86BB2F2E;
	Fri, 20 Jun 2025 01:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750382084; cv=none; b=pYA9Krl4DS2GXlRkq+WDXCbnLIe6HVMs6vRGm/cSiYywgCcXJ0uyV1HCyoSEN66Wv7a5O8hQ8SDT6tNKdZw3YG4frH6AeteI8w9SDSELKy9Fy0C+9AHGZhWAK6e5kp+zdZCDUQ79bJm7QmvV+1pjtSxOy9QMswMVOYZ9/YHhzNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750382084; c=relaxed/simple;
	bh=Dsx/DAdl0tEiCMAEUIvp795p4cwE8HOOEaafe9PDmjc=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=fHIJesiE+FiF4O3aOS9kwlJYyuqXzsJ15vARsjn9q9uvZHfFvTSySZ1HIX5LAFHTZwk9WNP0QIhlP/hKgk7p8ydBVqpT95f+O+g/o8B09Y+WUL8E7KSg+p+nWz0MPRioWXEP8NY3gwVrYjIPrLvXeXtF2QLqL2hU8+P/0/0wFs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rRTXi0LN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB18C4CEEA;
	Fri, 20 Jun 2025 01:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750382083;
	bh=Dsx/DAdl0tEiCMAEUIvp795p4cwE8HOOEaafe9PDmjc=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=rRTXi0LNmzA0StKuC9lozuLth9BGUvaeB9tDdcPoAAjBkEFjm6qms+/2tMaJnY+Wc
	 obmPp8mxqQevCmfp8oP73LU3NXfjMkc12zwmCPlJUWjfjUterSqLsES/8Xx3z5uRCp
	 Rbx1EGTOjrvp774bi2fFvWXH4w7Kk8yvb4r+UfWPOX9pBA5/FxKPpOwghyy//qS5C/
	 BGoWLnjhPBwoEVrVIUViOfum822QLB97YILtu6vGx5Lwma0ERUpIfsJuNeHZKMgbqJ
	 SzAFnZ0dbAaW9RNfOHayImTpSoWwVCOZVVzIFz/zp59iKyyhqcJOnmJd9KpYlNmcMG
	 4PHhIB6pC9Egw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <3db08ded39c09aaa5004b3b8b1238111f199e819.1746006578.git.ukleinek@baylibre.com>
References: <cover.1746006578.git.ukleinek@baylibre.com> <3db08ded39c09aaa5004b3b8b1238111f199e819.1746006578.git.ukleinek@baylibre.com>
Subject: Re: [PATCH 1/4] clk: pwm: Let .get_duty_cycle() return the real duty cycle
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-pwm@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Date: Thu, 19 Jun 2025 18:14:42 -0700
Message-ID: <175038208263.4372.17809878916180667511@lazor>
User-Agent: alot/0.11

Quoting Uwe Kleine-K=C3=B6nig (2025-04-30 02:57:46)
> pwm_get_state() returns the last requested pwm_state which might differ
> from what the lowlevel PWM driver actually implemented. For the purpose
> of .get_duty_cycle() the latter is the more interesting info, so use
> that to determine the output parameter.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> ---

Applied to clk-next

