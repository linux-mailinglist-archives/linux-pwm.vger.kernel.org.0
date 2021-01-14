Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBDAE2F649F
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Jan 2021 16:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbhANP3o convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Thu, 14 Jan 2021 10:29:44 -0500
Received: from mailout.easymail.ca ([64.68.200.34]:36522 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729394AbhANP3o (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 14 Jan 2021 10:29:44 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 2F62C22DFA;
        Thu, 14 Jan 2021 15:29:03 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at emo06-pco.easydns.vpn
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo06-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uL_p0CVqCAxw; Thu, 14 Jan 2021 15:29:03 +0000 (UTC)
Received: from laptop (unknown [108.162.141.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id CEB1C20F76;
        Thu, 14 Jan 2021 15:28:49 +0000 (UTC)
From:   Simon South <simon@simonsouth.net>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     tpiepho@gmail.com, thierry.reding@gmail.com, robin.murphy@arm.com,
        lee.jones@linaro.org, heiko@sntech.de, bbrezillon@kernel.org,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3 6/7] pwm: rockchip: Enable PWM clock of probed device only if running
References: <cover.1608735481.git.simon@simonsouth.net>
        <cb5a28d5fde04c09e9aace6ce619e445f895e0a8.1608735481.git.simon@simonsouth.net>
        <20210113075005.jftwu4ohrfyqwxyq@pengutronix.de>
Date:   Thu, 14 Jan 2021 10:22:34 -0500
In-Reply-To: <20210113075005.jftwu4ohrfyqwxyq@pengutronix.de> ("Uwe
        \=\?utf-8\?Q\?Kleine-K\=C3\=B6nig\=22's\?\= message of "Wed, 13 Jan 2021 08:50:05
 +0100")
Message-ID: <875z3ztuf9.fsf@simonsouth.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Uwe Kleine-König <u.kleine-koenig@pengutronix.de> writes:
> I don't see the advantage of this patch. In my eyes the code
> complication doesn't justify the gain (i.e. prevent the PWM clock
> being enabled for a few instructions).

I was starting to feel the same way after I sent out this series, so
let's just drop this change.

Thanks for the feedback, Uwe. I'll get a v4 out shortly.

-- 
Simon South
simon@simonsouth.net
