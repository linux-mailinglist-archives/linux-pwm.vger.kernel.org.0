Return-Path: <linux-pwm+bounces-6634-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B4CAEFADF
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jul 2025 15:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8EE81627A2
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jul 2025 13:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACB527465A;
	Tue,  1 Jul 2025 13:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKr1p6Ir"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A567149C51;
	Tue,  1 Jul 2025 13:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751377059; cv=none; b=JirVPoOVUBdgLzY/fcGARxTuGZ7uTCXCj2qCuuuEMJmwAkvQlAo/Lz88UuSzt5VU0EvEjImzyqifYLTlA8mtR6kUEhRuyDmosf3gTozMFJR0QY7733Nsp2GLorUYzXx2EUZSz39SRBPMVlakqUuxLcLCbqta4c33MbvXjdTJrgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751377059; c=relaxed/simple;
	bh=7kex+hChDbryDUCX0yvhuKf5gjmTH1H07CmQQ+0ixkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pmwtEwkjgT7e3DrSJ+3eWcSrxT28++APaHF1fohCUp5ocsuaHlWAOTLzZlBA+GsCE36ssrWMZRYGVDV2E3hvjXPzvRj9ld2evN4LQMxWlgciOQS1vrom2D/asAURHn5bEvTLhaffQR0zVsp5SpqUTdvnqaVasLl5+sWhP9vfpl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKr1p6Ir; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CACF5C4CEEB;
	Tue,  1 Jul 2025 13:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751377058;
	bh=7kex+hChDbryDUCX0yvhuKf5gjmTH1H07CmQQ+0ixkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DKr1p6Irs5p3Q2l07ebZSnZOUBCvJmUYkdiDMXD7fzSRJ8f1KwCy1dvYV1e6Jnw4G
	 RElvbVJ1q+heW0L1YKaIJJrUJxU5zTP74/E5rzwOnVXMBn9la4YPpMgVaKqbdgM4/P
	 Eqd9iJv5ulDvlIiDPo8x8MGX0MTu8PtxprL0h34QxmgwkCJ0bkVVzvDrpLO8Z/qh3P
	 vqR5K1YF3M3vsHfXAUQNT04/VWh61G6sS0FAVwCQo0yrrfiUpscqsCHncasPbzkfUp
	 KNungCRDRsy/woeVcKOpM9qzKeBN6EEIOKEt4M0RCh1CzEvsoBUBNhMKK/IkvXNhCE
	 XKOcuivHykfdQ==
Date: Tue, 1 Jul 2025 14:37:32 +0100
From: Lee Jones <lee@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>, nuno.sa@analog.com,
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-input@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Liu Ying <victor.liu@nxp.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v5 00/20] mfd: adp5585: support keymap events and drop
 legacy Input driver
Message-ID: <20250701133732.GO10134@google.com>
References: <20250614-dev-adp5589-fw-v5-0-7e9d84906268@analog.com>
 <20250619133834.GC795775@google.com>
 <d20682874dbd65acde8b80efa004706a09b23248.camel@gmail.com>
 <20250701110522.GK10134@google.com>
 <15ba1febb0f0acf4057af64c5c84db0633cab864.camel@gmail.com>
 <20250701111948.GK15184@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250701111948.GK15184@pendragon.ideasonboard.com>

On Tue, 01 Jul 2025, Laurent Pinchart wrote:

> On Tue, Jul 01, 2025 at 12:09:11PM +0100, Nuno Sá wrote:
> > On Tue, 2025-07-01 at 12:05 +0100, Lee Jones wrote:
> > > On Fri, 27 Jun 2025, Nuno Sá wrote:
> > > 
> > > > On Thu, 2025-06-19 at 14:38 +0100, Lee Jones wrote:
> > > > > On Sat, 14 Jun 2025, Nuno Sá via B4 Relay wrote:
> > > > > 
> > > > > > Hi all,
> > > > > > 
> > > > > > Here it goes v4. Main changes is to drop chip info based struct and
> > > > > > directly use an enum in the FW .data pointer, use the notifier API for
> > > > > > dispatching events and multiple calls to mfd_add_devices().
> > > > > > 
> > > > > > Regarding the last point, I think I could have used multiple calls to
> > > > > > devm_mfd_add_devices() and avoid those gotos in adp5585_add_devices()
> > > > > > but I do not feel that would have been "correct".
> > > > > > 
> > > > > > Thanks!
> > > > > > - Nuno Sá
> > > > > > 
> > > > > > ---
> > > > > > Changes in v5:
> > > > > 
> > > > > In future, these should be inside the patches themselves please.
> > > > 
> > > > Hi Lee,
> > > > 
> > > > I'm about to send v6. I just have a question regarding the above. Do you
> > > > mean to
> > > > have the log in the commit message itself like DRM or do it with git notes?
> > > 
> > > I have no idea what git notes is.
> > 
> > It pretty much adds a note before the diff stat but with an annoying "Notes:"
> > line. b4 seems to ignore it anyways.
> > 
> > > Simply place the Changelog inside the patch, just above the diff stat.
> > 
> > There's already some emails about this on v6. I ended up doing it DRM style
> > because tweaking the patch before sensing is surprisingly non trivial with b4.
> > Unless I missed something.
> 
> You can record the changelog in the commit message below a 
> 
> ---
> 
> line asyou modify commits. That way you won't have to write the
> changelogs when sending the patches, and b4 should not cause any issue.

Exactly this.  Should be easy enough.

-- 
Lee Jones [李琼斯]

