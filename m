Return-Path: <linux-pwm+bounces-7030-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C30C4B24671
	for <lists+linux-pwm@lfdr.de>; Wed, 13 Aug 2025 12:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D17A1689BE
	for <lists+linux-pwm@lfdr.de>; Wed, 13 Aug 2025 09:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13442F28E1;
	Wed, 13 Aug 2025 09:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5n4sAYF"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C6F2F0C7F;
	Wed, 13 Aug 2025 09:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755078967; cv=none; b=lUXcVUoRC2+qIAhA3Q/eyuoMez0Ed5Yy2iWqNcNnTU1bVTaI4NjvuA7X7Q3QFtC9iS9Crx4HDrpWORxnwu+hOHpKdk8JcSJfqxOkc240Hql03Y6+P6sTUlHN9vE2Y3RAhe36WVOvaNW5ZLHapQ6u43urtL1NOWXRaU8rIj1Alyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755078967; c=relaxed/simple;
	bh=yq7qT0lmQmc2RnGQA4ttrkxPbRZvFKWhGVf1sD5K4NA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GljZsgAJrBBtel3x1IHJT/YcW8bRx47LpWF6lKT2FbjFEKvaY0GCD7YyVudwFw9ohixrcx+/QossqOCGhY1ytl3Nnc7SsNgiSHzm3DVcjzZ4YznWuW0ZXRpdDD0lGse1Pwx+de1pSQ9eY5kcAMqvjgP8hKS6W3LVzEgfVMsBb7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5n4sAYF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A10DC4CEEB;
	Wed, 13 Aug 2025 09:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755078967;
	bh=yq7qT0lmQmc2RnGQA4ttrkxPbRZvFKWhGVf1sD5K4NA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k5n4sAYF5XGmPtdHN3T0EIqZ5XF3PmHoeXnJ9PNbHNoW0qelu7a20YPCQFJnYdWNZ
	 eQRvzr9HoP41ug+aP18xjIdvq/AUhanHxgL7LB4MecENbDYuSqYV+Qj2fdARDHABlm
	 GaTjHXkxZYzGP5sM9TZbnL2IayufberUiSGRa/o0KTnMwI7+32h4H416Oo2ABKinZS
	 D/XOxmLpi52Jtfk7NxVodR9uMJTAJuJFNiIqEatIneHeYjTLKdMYsqMXZUaDw7AJbl
	 y+Tdwta4l/yr2nd/bz39rZ52bl9lC+oyc7frvjH/OZYiM+NlM5XQ2SYANx3af+2rB1
	 X8YUIIPmT7OxA==
Date: Wed, 13 Aug 2025 09:56:04 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>, linux-pwm@vger.kernel.org,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] pwm: cros-ec: Avoid -Wflex-array-member-not-at-end
 warnings
Message-ID: <aJxhNNqt9PTtZKaW@google.com>
References: <aJtRPZpc-Lv-C6zD@kspp>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJtRPZpc-Lv-C6zD@kspp>

On Tue, Aug 12, 2025 at 11:35:41PM +0900, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Use the new TRAILING_OVERLAP() helper to fix the following warnings:
> 
> drivers/pwm/pwm-cros-ec.c:53:40: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/pwm/pwm-cros-ec.c:87:40: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> This helper creates a union between a flexible-array member (FAM)
> and a set of members that would otherwise follow it. This overlays
> the trailing members onto the FAM while preserving the original
> memory layout.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

