Return-Path: <linux-pwm+bounces-4521-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A768B9FD18B
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Dec 2024 08:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F12EF7A04C7
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Dec 2024 07:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF0814AD3D;
	Fri, 27 Dec 2024 07:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0vkNPsd"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73080149DFA;
	Fri, 27 Dec 2024 07:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735285353; cv=none; b=SZfzv9zaGqfGI5UtjK3LHaya8KKbhebFUIiodFL0d8/zU8DglAEFG14CUgyJyMAyYZlVs3AKX1gd/ron/M8hvTPIXdJEhaapkkRlJovn8t5n78K98LReot24o2Z12T0jvCFDxR5ZBdReKaa/57EW8Gr1ej5CVEQOrwitUosK/FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735285353; c=relaxed/simple;
	bh=yzjqwe7YAw9+sc6uCiawhBP9unb9wJPu48Etu3C6q+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cgTsUdjlTjIqXKCCC68q9BDKqEb0dritQd5TkXSOg5U8uKcgfQE4/wXPxaM+E6nhnPJzJAUAwgjQnynKWaIyM/p+Hmy+R9EKGgZWt33wb5jGUC6fbNiqhKX9j9fMcgd2ZlLTf0mOk1I8arNa0X2JBR11W1JS1Zk82I+VUGNx2y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0vkNPsd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DBE4C4CED0;
	Fri, 27 Dec 2024 07:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735285353;
	bh=yzjqwe7YAw9+sc6uCiawhBP9unb9wJPu48Etu3C6q+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y0vkNPsdVfn+oGfKYtgbAakEJtXAg71dK9JD9RFMTPRd9mtd+M45eoIsidksyee9O
	 K/Qc+BAawh/nrrRwdrkxN+UmVe2F11jKY3unrfQzQQBsuyZnU4qiBdUzsxRaBZXd1Z
	 ShFO5A25PC9/PpKki0zUQOLQKIAuIEnxMTiOZPbEXldQN/qHnV7egzlVVxk0XA9X5z
	 9yQLFUsxDuJc8X7pdQnK7YUbyGYvG1hFOL4XFW5G9jqFjHoW9bWNdy5quO3bWXkNii
	 /D4dO1Y66l3MthZBlouE8B0UlFcBjD/eEK6Y9kZi1bzyVEhiSOKa9WXdxmmYEClk1k
	 tNd9l775NIQkQ==
Date: Fri, 27 Dec 2024 08:42:30 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: heiko@sntech.de, linux-rockchip@lists.infradead.org, 
	linux-pwm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 11/17] dt-bindings: pwm: rockchip: Add
 rockchip,rk3562-pwm
Message-ID: <c3r3ezqr6sg7vtvomngjchzlk6btyzrjtukezjvuqxesqbtrh5@cmlu3bw7dyzl>
References: <20241224094920.3821861-1-kever.yang@rock-chips.com>
 <20241224094920.3821861-12-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241224094920.3821861-12-kever.yang@rock-chips.com>

On Tue, Dec 24, 2024 at 05:49:14PM +0800, Kever Yang wrote:
> Add rockchip,rk3562-pwm compatible string.

This we see from the diff. Say something not obvious. Where is the
driver change? Why devices are or are not compatible?

Best regards,
Krzysztof


