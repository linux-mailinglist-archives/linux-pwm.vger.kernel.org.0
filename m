Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1A97C73B7
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 19:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378915AbjJLRGx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 13:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347328AbjJLRGx (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 13:06:53 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B90CF;
        Thu, 12 Oct 2023 10:06:52 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 810BD5C037B;
        Thu, 12 Oct 2023 13:06:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 12 Oct 2023 13:06:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1697130411; x=1697216811; bh=Y9ay1WFzOeK0fmlkvH2MYCYd06kKXCzgro5
        A0So2Lsg=; b=NwBoV3THzm6Zm1ZTcRw4n5YTYvyst9kGLEq6Z35CD7hUj3QBp5j
        lZObicmYguLV+aME8PVbOzObp+F4e6O5ZB0JQaPmvyISlcn9MJKHNXJGNOuLxLrp
        MiZ8f7CotqlTirgTkGkjnkSYfpmftvpiGrJ/YIHNwCmZBwLYE34M3oXmdisRfImN
        wokjwxkrDgLoeP1EpaBDyYYqFmHBUc9Wh7braajzKe2bZ18WfAT4Y88S/Cs+G7TR
        2rdSujShKEjwh2KSZbHbaQc5k3+vnbciBSJ3F9TsJMlZ4S1qA9nJ1KsolSeHeVho
        Rv/NGlj8i3rNRq4husj3YvnHkIT3du6OUsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1697130411; x=1697216811; bh=Y9ay1WFzOeK0fmlkvH2MYCYd06kKXCzgro5
        A0So2Lsg=; b=SsYvGqEnfcTDFW2l1MsxRjpzfcLZFbN8a/7zdldrtfaUNmdMiR+
        FTx24MMhCFckHmBCJ8mvYoO3SPe8Y49BvbkGHrACbko48Z6JOZL9Ea2Rf4dMmkPC
        RlGKsLtk5K3K6G599i42ch5Z75cCErs1y5dV7oDKYxakvELPCBkoo4k41kIdNI/l
        m+xLll85gm4QpK7F95hTEDSWwjXDJ9AV4QeSlwUUcUqYfQZ49gp4yjUF5wGNOflT
        21CmDyhon/rLpgREAKtevlSpNLsJPwcboEAF0dRtheyJgtBs6QGWgqxuLyT4SjCG
        lJRPA8dS3i7XSAncPJdltLjQQN1OsfLKq9w==
X-ME-Sender: <xms:qycoZUdW5tBQz8pX2GjN5WceVAgmHi-pJUN7CahsiO4iGB3vKzz_TA>
    <xme:qycoZWOiAEcqC_Ql_tmUvZC_QuAN9oRoxDHWhXEsxnGNXfUe7aYHqgJxDGAxHvUo9
    qVnk1AcIE0ZUA>
X-ME-Received: <xmr:qycoZVhuzlHw6r4P4Ej91MCgT0M1ot0V84ikQciYNaJvNkhE4Eg1_kAIDd5Dbp_kkW-WBNEdlsz854UfaDGHooKsPsOUEZdLWvVBNXAZK_o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedriedtgdellecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtudenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepgeevve
    etgfevjeffffevleeuhfejfeegueevfeetudejudefudetjedttdehueffnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:qycoZZ93C5pnOfeCTJEscx0joqJ0jFUo__CDBGBGW7kUE70f52CXCg>
    <xmx:qycoZQuNMkmKUzyFdrHVtJ79HwLbB_Njc6URBEt8_CWQRHtOVTrRrw>
    <xmx:qycoZQGMSKbuSKmHIeTaLBP7wn_c5OKhb2sEmqx8iD3i3PZDrClB6A>
    <xmx:qycoZeCc1ZletHI2eZsAejR_j9-IzbawUl8lJ095JMU8Jhn62_-FGg>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Oct 2023 13:06:50 -0400 (EDT)
Date:   Thu, 12 Oct 2023 19:06:48 +0200
From:   Greg KH <greg@kroah.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     stable@vger.kernel.org, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de, Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH stable 5.4.y] pwm: hibvt: Explicitly set .polarity in
 .get_state()
Message-ID: <2023101241-geologic-barley-dbe6@gregkh>
References: <20231009134309.243860-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231009134309.243860-1-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Oct 09, 2023 at 03:43:09PM +0200, Uwe Kleine-König wrote:
> [ Upstream commit 6f57937980142715e927697a6ffd2050f38ed6f6 ]
> 
> The driver only both polarities. Complete the implementation of
> .get_state() by setting .polarity according to the configured hardware
> state.
> 
> Fixes: d09f00810850 ("pwm: Add PWM driver for HiSilicon BVT SOCs")
> Link: https://lore.kernel.org/r/20230228135508.1798428-2-u.kleine-koenig@pengutronix.de
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> this is a backport to 5.4.257. The original was backported to
> 
> - v5.10.179 as commit 155b2586de3f171d46c8a1955990d4676487501e
> - v5.15.109 as commit 78559037632b8343b85fb1e2d0b55405c2b73b4a
> - v6.1.24 as commit 98ba763cc91c8e0117ccc28e300640eee52f9b44
> - v6.2.11 as commit 28ab26f6a95b4bda64cba22704484d209aad5417
> 
> A direct
> 
> 	git cherry-pick 6f57937980142715e927697a6ffd2050f38ed6f6
> 
> on 5.4.257 fails with a conflict, but the same happend on 5.10.y and
> 5.15.y, where it was backported correctly. So
> 
> 	git cherry-pick 78559037632b8343b85fb1e2d0b55405c2b73b4a
> 
> works just fine and results in this patch. Cherry-picking
> 78559037632b8343b85fb1e2d0b55405c2b73b4a also works fine on for 4.19.y
> and 4.14.
> 
> Note there is a broken sentence in the commit log, s/only/supports/
> would be appropriate. I am unsure however if I'm allowed to fix it or if
> the commit log has to be exactly the same as the original.

Now queued up, thanks.

greg k-h
