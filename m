Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D8965DADA
	for <lists+linux-pwm@lfdr.de>; Wed,  4 Jan 2023 17:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbjADQ6c (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 4 Jan 2023 11:58:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240153AbjADQ57 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 4 Jan 2023 11:57:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B961AD89;
        Wed,  4 Jan 2023 08:56:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6A4B617B8;
        Wed,  4 Jan 2023 16:56:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E33D6C433F0;
        Wed,  4 Jan 2023 16:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672851388;
        bh=hNg2KCjGN/+hO1CDPYPD+sYYndFZZJFLvZf6emCiJnY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GPGdttsGGbW0CiN5eQuLqri5hH0tzZrG+HxP58iRRAML3SlhmmQqn2AYypPwCFjWm
         J6uFK1ygCgsQ9k8ttWnZCJRAkeLHmxZ6JC3awXsrNV64H0wzVc2FHWIy+fMFJPW0BR
         UcJE7sooZqVED1E9UoHXvYlVUoiz7PbhGbDlgwmO/aT2ZV+luUWYZOL/9R+EILtrhl
         rBNYpbOJH4MFwWet5E7qtFlltWx3l8wzNjsMWlJ7GP4qtHdOrF71M5GielqjH1onqz
         2OfCaNOzTQsLvbWsgSSq5Zv/8nLHPbgAr8kTK+cafznxJ7NCPwHcTc/vX+NPdOOk4l
         zJl+iy154ZK8A==
Date:   Wed, 4 Jan 2023 16:56:21 +0000
From:   Lee Jones <lee@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 04/11] leds: qcom-lpg: Propagate errors in
 .get_state() to the caller
Message-ID: <Y7WvtRoffqWgMohv@google.com>
References: <20221130152148.2769768-1-u.kleine-koenig@pengutronix.de>
 <20221130152148.2769768-5-u.kleine-koenig@pengutronix.de>
 <Y45xKswRnao8P8Mf@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y45xKswRnao8P8Mf@duo.ucw.cz>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, 05 Dec 2022, Pavel Machek wrote:

> Hi!
> 
> > .get_state() can return an error indication. Make use of it to propagate
> > failing hardware accesses.
> > 
> > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> Acked-by: Pavel Machek <pavel@ucw.cz>

What's the merge strategy for this?  Can it go in on its own?

-- 
Lee Jones [李琼斯]
