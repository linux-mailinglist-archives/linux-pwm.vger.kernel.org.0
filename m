Return-Path: <linux-pwm+bounces-1485-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBA385475C
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 11:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1E0C1F220C8
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB96199B0;
	Wed, 14 Feb 2024 10:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vkdE4AfI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1905199AB;
	Wed, 14 Feb 2024 10:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707907257; cv=none; b=dQFvvbesSLnBiyqGhro83w3Jh9A1mIxfeDW8kMhJkHzJQQJqVzMNOHTbZ2w2QLoN0yjs/4psYOWkzWMj6Rh52jqrbKBc11v7eeADzM5BQcbH+MplbTZszDFFYtbkdNqimGew62iJWEwHc7UXWeIr4g2qbxKDkmwzHQ6Ys5utmvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707907257; c=relaxed/simple;
	bh=HhjUPIGGiQ/t6SaonN/idlU0p41y8Rzev9HMWOO09jY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODijk2yDdxpx6yj0WDyMg6rOYfVxNUKKXDGBsycceAL/pWAZw01vS+B+k+GkwwCgmykdMdhTsab+xrpDsR+sk79N6qANEcTE+7/efh86RE3sruU3chXihETCki0sLDzHc3xJZSkuOyRdvypYGHqIIeZWo1ihl39TPHjlttAFMSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vkdE4AfI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEBC3C43390;
	Wed, 14 Feb 2024 10:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707907257;
	bh=HhjUPIGGiQ/t6SaonN/idlU0p41y8Rzev9HMWOO09jY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vkdE4AfI3FcKFvbzeYeycQBJ6h/C+MVwBS7U9+SMx8BN3N44Lt0WvPp53HB+0JLJa
	 fU8/Hr9Xoq93GONDzXQuObUMafiekvkYjRBYUraFI3tTR8nb4nchwG2E2BT28E1GQY
	 7N6oT4aqeumzRTH6ZG40a4sUoaMO9HeGMFrX7HR0=
Date: Wed, 14 Feb 2024 11:40:52 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>, greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev, kernel@pengutronix.de
Subject: Re: [PATCH v6 158/164] staging: greybus: pwm: Drop unused
 gb_connection_set_data()
Message-ID: <2024021446-custody-smudgy-e7c3@gregkh>
References: <cover.1707900770.git.u.kleine-koenig@pengutronix.de>
 <bd2759c325c295f3d9f990609d97eb83a8ca88b8.1707900770.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bd2759c325c295f3d9f990609d97eb83a8ca88b8.1707900770.git.u.kleine-koenig@pengutronix.de>

On Wed, Feb 14, 2024 at 10:33:25AM +0100, Uwe Kleine-König wrote:
> The driver never calls gb_connection_get_data(). If there was another
> caller (say the greybus core) it cannot use the value because the type
> of pwmc (= struct gb_pwm_chip) is only defined in the pwm driver.
> 
> So drop the call to gb_connection_set_data().
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

