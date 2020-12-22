Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0262E0D5B
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Dec 2020 17:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbgLVQ17 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Tue, 22 Dec 2020 11:27:59 -0500
Received: from mailout.easymail.ca ([64.68.200.34]:36188 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbgLVQ17 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 22 Dec 2020 11:27:59 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 3D5E3BFC9F;
        Tue, 22 Dec 2020 16:27:18 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at emo04-pco.easydns.vpn
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo04-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1X26B3-7hQwg; Tue, 22 Dec 2020 16:27:18 +0000 (UTC)
Received: from jupiter (unknown [108.162.141.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id EE1EEC2CCB;
        Tue, 22 Dec 2020 16:27:05 +0000 (UTC)
From:   Simon South <simon@simonsouth.net>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, heiko@sntech.de, bbrezillon@kernel.org,
        linux-rockchip@lists.infradead.org, thierry.reding@gmail.com,
        tpiepho@gmail.com, lee.jones@linaro.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/3] pwm: rockchip: Eliminate potential race
 condition when probing
References: <cover.1608407584.git.simon@simonsouth.net>
        <fcfb96fd2fd860ae3f08cb563c74eb864cdab41a.1608407584.git.simon@simonsouth.net>
        <20201221085047.nyl7hacd4imp37qi@pengutronix.de>
Date:   Tue, 22 Dec 2020 11:26:59 -0500
In-Reply-To: <20201221085047.nyl7hacd4imp37qi@pengutronix.de> ("Uwe
        =?utf-8?Q?Kleine-K=C3=B6nig=22's?= message of "Mon, 21 Dec 2020 09:50:47
 +0100")
Message-ID: <875z4trelo.fsf@simonsouth.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:
> I wonder if the commit log should be more detailed about this, after
> reading it I thought the effect of the bug would be that the PWM stops
> even though it should oscillate.

Your understanding is correct; this was the result of confusion on my
part. I'll write a new commit message.

>> Also refactor the code slightly to eliminate goto targets as the
>> error handlers no longer share any recovery steps.
>
> This however makes it hard to review the patch. Maybe this refactoring
> can be split out?

I'll give this another shot, too.

-- 
Simon South
simon@simonsouth.net
