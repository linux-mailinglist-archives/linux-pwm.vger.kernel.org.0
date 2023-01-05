Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4767B65F124
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Jan 2023 17:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbjAEQ3m (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 5 Jan 2023 11:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232244AbjAEQ3g (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 5 Jan 2023 11:29:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8216458304;
        Thu,  5 Jan 2023 08:29:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C13761B6B;
        Thu,  5 Jan 2023 16:29:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CDE8C433EF;
        Thu,  5 Jan 2023 16:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672936174;
        bh=N2VgeA/QWTLrQNiyye8P36PFpcfcPKldrAzdqapag/U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MQVllf6ZKHufEd2O7LtOTsP2f+uP6+8Q74JYnIY/ebw2Z5MXOqhj50+ed2s4yHwGO
         KRfI2yYnMgqAn9JqJN9dFIU994r7pKaqRVn2zVZ/KYiPV1z9bM+0SzMjseTG6lD6uV
         ZN4VchMFZZKb2N4/TlCuf1QbdonIf72kybom2rBkG4LZHMw4LfaXe2TQ3Dg1bDiKCS
         9MIAaMNtzkJO50n/QT1rU18tBjq4n2kzwmDnijjk7SymOXRh+vVyye9bYARCft3vaJ
         oRcChhHUg9RMTUZMXQcvg7N5hIpE3N1BMkZlADJGISLRsBFswUgKO3FFq1MJMZqw9y
         +w3Yz1ndfzRyw==
Date:   Thu, 5 Jan 2023 16:29:28 +0000
From:   Lee Jones <lee@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Thierry Reding <thierry.reding@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 04/11] leds: qcom-lpg: Propagate errors in
 .get_state() to the caller
Message-ID: <Y7b66AKdRzqoRYst@google.com>
References: <20221130152148.2769768-1-u.kleine-koenig@pengutronix.de>
 <20221130152148.2769768-5-u.kleine-koenig@pengutronix.de>
 <Y45xKswRnao8P8Mf@duo.ucw.cz>
 <Y7WvtRoffqWgMohv@google.com>
 <20230105135438.j7fdocows5pmtwyr@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230105135438.j7fdocows5pmtwyr@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, 05 Jan 2023, Uwe Kleine-König wrote:

> On Wed, Jan 04, 2023 at 04:56:21PM +0000, Lee Jones wrote:
> > On Mon, 05 Dec 2022, Pavel Machek wrote:
> > 
> > > Hi!
> > > 
> > > > .get_state() can return an error indication. Make use of it to propagate
> > > > failing hardware accesses.
> > > > 
> > > > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > > 
> > > Acked-by: Pavel Machek <pavel@ucw.cz>
> > 
> > What's the merge strategy for this?  Can it go in on its own?
> 
> It's already in Linus's tree as fea768cf68c04d68ea2a8091c559667378f3b77c.

Interesting.  All good then, thanks for letting me know.

-- 
Lee Jones [李琼斯]
