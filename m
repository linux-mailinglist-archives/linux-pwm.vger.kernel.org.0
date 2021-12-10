Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB2846FE46
	for <lists+linux-pwm@lfdr.de>; Fri, 10 Dec 2021 10:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236428AbhLJKBC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 10 Dec 2021 05:01:02 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:46100 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbhLJKBC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 10 Dec 2021 05:01:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id AC5C5CE24DA
        for <linux-pwm@vger.kernel.org>; Fri, 10 Dec 2021 09:57:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB64EC00446;
        Fri, 10 Dec 2021 09:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639130244;
        bh=6TK5KJYUieI7fot8D+MAUimgBqski6Hv+qhdP/pOEzE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=GhJBtsvdEx9Gt+SSMCnPwE1HF0KyPEM9BGxCHmeT9iGuWhPECcsrjZYo61Oj08W1g
         lgTJyxT/0Nw0aE139ksZWDmnd2SVs3Pe2vf78xX7TnVrOwsxZNkVYGvMzEbW5cq3wL
         JSNSVRV3mIHOdo6HIyiqrL+AWFSzQq1trdH4DPYolLVnw9RIhowC72+WHAd8KbBi8w
         PerCUtyLuwB03qkYagfzIf9aLozeoCVOY5n7NZw4XrvnAJCIHze3LcQRQZBHxeePFH
         8ixSCakE43AcOsCGKaglZKsnpoer2sOKGSh0mRPVVSU7hILv6qnsBdu41W6ESb6IP3
         NtUdS6L9UHy+Q==
Message-ID: <aa94635e2afc50158a60a6adb2bc89bbdf8f056b.camel@kernel.org>
Subject: Re: [PATCH] pwm: raspberrypi-poe: Drop assignment to struct
 pwmchip::base
From:   nicolas saenz julienne <nsaenz@kernel.org>
To:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Date:   Fri, 10 Dec 2021 10:57:21 +0100
In-Reply-To: <20211209220851.1319460-1-u.kleine-koenig@pengutronix.de>
References: <20211209220851.1319460-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, 2021-12-09 at 23:08 +0100, Uwe Kleine-König wrote:
> Since commit f9a8ee8c8bcd ("pwm: Always allocate PWM chip base ID
> dynamically") there is no effect any more for assigning this variable.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---

Reviewed-by: Nicolas Saenz Julienne <nsaenz@kernel.org>

Regards,
Nicolas
